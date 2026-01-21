import 'package:json_annotation/json_annotation.dart';

part 'login_response_modal.g.dart';

@JsonSerializable()
class LoginResponseModal {
  final String message;
  final Tokens tokens;
  final User user;

  LoginResponseModal({
    required this.message,
    required this.tokens,
    required this.user,
  });

  factory LoginResponseModal.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModalFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModalToJson(this);
}

@JsonSerializable()
class Tokens {
  @JsonKey(name: 'refresh-token')
  final String refreshToken;
  @JsonKey(name: 'access-token')
  final String accessToken;
  Tokens({required this.accessToken, required this.refreshToken});
  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
  Map<String, dynamic> toJson() => _$TokensToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String username;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
