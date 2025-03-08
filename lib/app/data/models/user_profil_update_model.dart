// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfilUpdate {
  String? name;
  String? avatar;
  String? phone;
  String? password;
  String? oldPassword;
  UserProfilUpdate({
    this.name,
    this.avatar,
    this.phone,
    this.password,
    this.oldPassword,
  });

  UserProfilUpdate copyWith({
    String? name,
    String? avatar,
    String? phone,
    String? password,
    String? oldPassword,
  }) {
    return UserProfilUpdate(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      oldPassword: oldPassword ?? this.oldPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'password': password,
      'old_password': oldPassword,
    };
  }

  factory UserProfilUpdate.fromMap(Map<String, dynamic> map) {
    return UserProfilUpdate(
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      oldPassword:
          map['old_password'] != null ? map['old_password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfilUpdate.fromJson(String source) =>
      UserProfilUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfilUpdate(name: $name, avatar: $avatar, phone: $phone, password: $password, oldPassword: $oldPassword)';
  }

  @override
  bool operator ==(covariant UserProfilUpdate other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.avatar == avatar &&
        other.phone == phone &&
        other.password == password &&
        other.oldPassword == oldPassword;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        oldPassword.hashCode;
  }
}
