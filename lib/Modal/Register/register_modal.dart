import 'package:json_annotation/json_annotation.dart';

part 'register_modal.g.dart';

@JsonSerializable()
class RegisterModal {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  RegisterModal({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterModal.fromJson(Map<String, dynamic> json) =>
      _$RegisterModalFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModalToJson(this);
}
