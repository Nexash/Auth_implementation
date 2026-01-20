// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModal _$RegisterModalFromJson(Map<String, dynamic> json) =>
    RegisterModal(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$RegisterModalToJson(RegisterModal instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
