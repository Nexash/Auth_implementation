// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModal _$RegisterModalFromJson(Map<String, dynamic> json) =>
    RegisterModal(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirm_password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$RegisterModalToJson(RegisterModal instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
