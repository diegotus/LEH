import 'package:flutter/foundation.dart' show listEquals;

class PaginateListData<T> {
  final List<T> items;
  final int total;
  PaginateListData({
    required this.items,
    required this.total,
  });

  PaginateListData<T> copyWith({
    List<T>? items,
    int? total,
  }) {
    return PaginateListData<T>(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  @override
  bool operator ==(covariant PaginateListData<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items) && other.total == total;
  }

  @override
  int get hashCode => items.hashCode ^ total.hashCode;
}
