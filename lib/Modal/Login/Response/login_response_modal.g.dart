// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModal _$LoginResponseModalFromJson(Map<String, dynamic> json) =>
    LoginResponseModal(
      message: json['message'] as String,
      tokens: Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModalToJson(LoginResponseModal instance) =>
    <String, dynamic>{
      'message': instance.message,
      'tokens': instance.tokens,
      'user': instance.user,
    };

Tokens _$TokensFromJson(Map<String, dynamic> json) => Tokens(
  accessToken: json['access-token'] as String,
  refreshToken: json['refresh-token'] as String,
);

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
  'refresh-token': instance.refreshToken,
  'access-token': instance.accessToken,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String,
  username: json['username'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'username': instance.username,
};
