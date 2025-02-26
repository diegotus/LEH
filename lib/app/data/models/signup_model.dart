// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

SignupModel signUpModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signUpModelToJson(SignupModel data) => json.encode(data.toJson());

class ForgotPasswordResponseModel extends SignupModel {
  ForgotPasswordResponseModel({super.email, super.message});

  factory ForgotPasswordResponseModel.fromMap(json) {
    var signUpModel = SignupModel.fromMap(json);
    return ForgotPasswordResponseModel(
      email: signUpModel.email,
      message: signUpModel.message,
    );
  }

  @override
  String toString() => super
      .toString()
      .replaceFirst("SignupModel", "ForgotPasswordResponseModel");
}

class SignupModel {
  String? email;
  String? message;

  SignupModel({
    this.email,
    this.message,
  });

  SignupModel copyWith({
    String? email,
    String? message,
  }) {
    return SignupModel(
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'message': message,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      email: map['email'] != null ? map['email'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignupModel(email: $email, message: $message)';

  @override
  bool operator ==(covariant SignupModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.message == message;
  }

  @override
  int get hashCode => email.hashCode ^ message.hashCode;
}

class OTPModel extends SignupModel {
  OTPModel({super.email, super.message, this.otpValidity});

  double? otpValidity;

  @override
  OTPModel copyWith({
    String? email,
    String? message,
    double? otpValidity,
  }) {
    return OTPModel(
      email: email ?? this.email,
      message: message ?? this.message,
      otpValidity: otpValidity ?? this.otpValidity,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'message': message,
      'otpValidity': otpValidity,
    };
  }

  factory OTPModel.fromMap(Map<String, dynamic> map) {
    return OTPModel(
      email: map['email'] != null ? map['email'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      otpValidity: map['otpValidity'] != null
          ? double.parse('${map['otpValidity'] ?? "3"}')
          : 3,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory OTPModel.fromJson(String source) =>
      OTPModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OTPModel(email: $email, message: $message, otpValidity: $otpValidity)';

  @override
  bool operator ==(covariant OTPModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.message == message &&
        other.otpValidity == otpValidity;
  }

  @override
  int get hashCode => email.hashCode ^ message.hashCode ^ otpValidity.hashCode;
}
