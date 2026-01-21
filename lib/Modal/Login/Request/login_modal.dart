import 'package:json_annotation/json_annotation.dart';

part 'login_modal.g.dart';

//to generate -> dart run build_runner build
//if there is conflict -> dart run build_runner build --delete-conflicting-outputs
// to watch -> dart run build_runner watch

@JsonSerializable()
class LoginModal {
  final String email;
  final String password;
  LoginModal({required this.email, required this.password});

  factory LoginModal.fromJson(Map<String, dynamic> json) =>
      _$LoginModalFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModalToJson(this);
}
