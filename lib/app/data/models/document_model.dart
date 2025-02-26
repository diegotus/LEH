// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as paths;

class DocumentData {
  String? id;
  String? mimeType;
  String? name;
  int? size;
  Uint8List? bytes;
  String? path;
  DocumentData({
    this.id,
    this.mimeType,
    this.name,
    this.size,
    this.bytes,
    this.path,
  });

  DocumentData copyWith({
    String? mimeType,
    String? name,
    int? size,
    Uint8List? bytes,
    String? path,
    String? id,
  }) {
    return DocumentData(
      mimeType: mimeType ?? this.mimeType,
      name: name ?? this.name,
      size: size ?? this.size,
      bytes: bytes ?? this.bytes,
      path: path ?? this.path,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mimeType': mimeType,
      'name': name,
      'size': size,
      'bytes': bytes,
      'path': path,
      'id': id,
    };
  }

  factory DocumentData.fromMap(Map<String, dynamic> map) {
    return DocumentData(
      mimeType: map['mimeType'] != null ? map['mimeType'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      size: map['size'] != null ? map['size'] as int : null,
      bytes: map['bytes'] != null ? Uint8List.fromList(map['bytes']) : null,
      path: map['path'] != null ? map['path'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentData.fromJson(String source) =>
      DocumentData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentData(mimeType: $mimeType, name: $name, size: $size, bytes: $bytes, path: $path, id: $id)';
  }

  @override
  bool operator ==(covariant DocumentData other) {
    if (identical(this, other)) return true;

    return other.mimeType == mimeType &&
        other.name == name &&
        other.size == size &&
        other.bytes == bytes &&
        other.path == path &&
        other.id == id;
  }

  @override
  int get hashCode {
    return mimeType.hashCode ^
        name.hashCode ^
        size.hashCode ^
        bytes.hashCode ^
        path.hashCode ^
        id.hashCode;
  }
}

class FileData {
  bool hasFile;
  String name;
  String mimeType;
  String path;
  Uint8List? bytes;
  int? size;
  FileData({
    required this.hasFile,
    required this.name,
    required this.mimeType,
    required this.path,
    this.bytes,
    this.size,
  });

  String get baseName {
    String fileName = paths.basename(path);
    return fileName;
  }

  FileData copyWith({
    bool? hasFile,
    String? name,
    String? mimeType,
    String? path,
    Uint8List? bytes,
    int? size,
  }) {
    return FileData(
      hasFile: hasFile ?? this.hasFile,
      name: name ?? this.name,
      mimeType: mimeType ?? this.mimeType,
      path: path ?? this.path,
      bytes: bytes ?? this.bytes,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hasFile': hasFile,
      'name': name,
      'mimeType': mimeType,
      'path': path,
      'bytes': bytes,
      'size': size,
    };
  }

  factory FileData.fromMap(Map<String, dynamic> map) {
    return FileData(
      hasFile: map['hasFile'] as bool,
      name: map['name'] as String,
      mimeType: map['mimeType'] as String,
      path: map['path'] as String,
      bytes: map['bytes'] != null ? Uint8List.fromList(map['bytes']) : null,
      size: map['size'] != null ? map['size'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileData.fromJson(String source) =>
      FileData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileData(hasFile: $hasFile, name: $name, mimeType: $mimeType, path: $path, bytes: $bytes, size: $size)';
  }

  @override
  bool operator ==(covariant FileData other) {
    if (identical(this, other)) return true;

    return other.hasFile == hasFile &&
        other.name == name &&
        other.mimeType == mimeType &&
        other.path == path &&
        other.bytes == bytes &&
        other.size == size;
  }

  @override
  int get hashCode {
    return hasFile.hashCode ^
        name.hashCode ^
        mimeType.hashCode ^
        path.hashCode ^
        bytes.hashCode ^
        size.hashCode;
  }
}
