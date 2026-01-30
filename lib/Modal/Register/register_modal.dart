import 'package:json_annotation/json_annotation.dart';

part 'register_modal.g.dart';

// dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class RegisterModal {
  final String username;
  final String email;
  final String password;
  @JsonKey(name: "confirm_password")
  final String confirmPassword;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  RegisterModal({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterModal.fromJson(Map<String, dynamic> json) =>
      _$RegisterModalFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModalToJson(this);
}
