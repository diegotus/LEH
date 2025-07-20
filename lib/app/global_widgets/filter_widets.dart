// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/core/utils/kiwoo_icons.dart';
import 'package:haiti_lotri/app/global_widgets/app_button.dart';

import '../core/utils/app_colors.dart' show AppColors;
import '../core/utils/app_string.dart' show AppStrings;
import '../core/utils/app_utility.dart' show horizontalSpaceTiny;
import '../core/utils/datetime_utility.dart';

class _DateFilterData {
  String? type;
  DateTime? date;
  _DateFilterData({this.type, this.date});

  _DateFilterData copyWith({String? type, DateTime? date}) {
    return _DateFilterData(type: type ?? this.type, date: date ?? this.date);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory _DateFilterData.fromMap(Map<String, dynamic> map) {
    return _DateFilterData(
      type: map['type'] as String,
      date:
          map['date'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory _DateFilterData.fromJson(String source) =>
      _DateFilterData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '_DateFilterData(type: $type, date: $date)';

  @override
  bool operator ==(covariant _DateFilterData other) {
    if (identical(this, other)) return true;

    return other.type == type && other.date == date;
  }

  @override
  int get hashCode => type.hashCode ^ date.hashCode;
}

class DropdownFilterItem<T> {
  T? value;
  String title;
  DropdownFilterItem({this.value, required this.title});
}

class DateFilter extends StatelessWidget {
  const DateFilter({super.key, required this.onUpdate});
  final void Function(DateTime? date) onUpdate;

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (date) => DropdownFilterButton<String>(
        // isExpanded: true,
        items: [
          DropdownMenuItem(value: null, child: Text(AppStrings.ALL)),
          DropdownMenuItem(value: "Today", child: Text(AppStrings.TODAY)),
          DropdownMenuItem(
            value: "Yesterday",
            child: Text(AppStrings.YESTERDAY),
          ),
          DropdownMenuItem(value: "Custom", child: Text(AppStrings.CUSTOM)),
        ],
        value: date.value.type,
        onChanged: (p0) {
          if (p0 != "Custom") {
            if (p0 != date.value.type) {
              DateTime? newDate = DateTime.now();
              if (p0 == "Yesterday") {
                newDate = newDate.subtract(Duration(days: 1));
              } else if (p0 == null) {
                newDate = null;
              }
              date.value = date.value.copyWith(type: p0, date: newDate);
              onUpdate(newDate);
            }
          } else {
            showDatePicker(
              context: context,
              initialDate: date.value.date,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              firstDate: DateTimeUtility.convertDateFromString("2025-01-01"),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null && value != date.value.date) {
                onUpdate(value);
                date.value = date.value.copyWith(type: p0, date: value);
              }
            });
          }
        },
        selectedItemBuilder: (context, items, value) {
          return [
            ...items!.map((el) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Kiwoo.calendar_alt, color: AppColors.PRIMARY1),
                  horizontalSpaceTiny,
                  if (value != "Custom" || el.value != "Custom")
                    el
                  else
                    DropdownMenuItem(
                      value: "Custom",
                      child: Text(date.value.date!.format("dd-MM-yyyy")),
                    ),
                ],
              );
            }),
          ];
        },
      ),
      Rx<_DateFilterData>(_DateFilterData()),
    );
  }
}

class DropDownFilter<T> extends GetWidget {
  const DropDownFilter({
    super.key,
    required this.onUpdate,
    this.items = const [],
    this.initialValue,
    this.icon,
  });
  final void Function(T? date) onUpdate;
  final T? initialValue;
  final List<DropdownFilterItem> items;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (selected) => DropdownFilterButton<T>(
        // isExpanded: true,
        items: [
          ...items.map(
            (el) => DropdownMenuItem(value: el.value, child: Text(el.title)),
          ),
        ],
        value: selected.value,
        onChanged: (p0) {
          if (p0 != selected.value) {
            selected.value = p0;

            onUpdate(p0);
          }
        },
        selectedItemBuilder:
            icon != null
                ? (context, items, value) {
                  print("the icons");
                  return [
                    ...items!.map((el) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [icon!, horizontalSpaceTiny, el],
                      );
                    }),
                  ];
                }
                : null,
      ),
      Rx<T?>(initialValue),
    );
  }
}
