// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

import 'package:haiti_lotri/app/core/utils/enums.dart';

import '../../../routes/app_pages.dart';

class GameWidgetModel {
  final Gametype type;
  final String image;
  GameWidgetModel({
    required this.type,
    required this.image,
  });
  void onTap() {
    Get.toNamed(Routes.LOTO_GAME, arguments: type);
  }

  GameWidgetModel copyWith({
    Gametype? type,
    String? image,
  }) {
    return GameWidgetModel(
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'image': image,
    };
  }

  factory GameWidgetModel.fromMap(Map<String, dynamic> map) {
    return GameWidgetModel(
      type: Gametype.fromString(map['type']),
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameWidgetModel.fromJson(String source) =>
      GameWidgetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GameWidgetModel(type: $type, image: $image)';

  @override
  bool operator ==(covariant GameWidgetModel other) {
    if (identical(this, other)) return true;

    return other.type == type && other.image == image;
  }

  @override
  int get hashCode => type.hashCode ^ image.hashCode;
}
