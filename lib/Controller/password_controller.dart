import 'dart:developer';

import 'package:auth_implementation/Service/password_service.dart';
import 'package:auth_implementation/Utils/API_Utils/api_exception.dart';
import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:flutter/material.dart';

class PasswordController extends ChangeNotifier {
  final PasswordService _passwordService;
  final LocalStorage _localStorage;
  LocalStorage get localStorage => _localStorage;
  bool isLoading = false;

  String? errorMessage;

  PasswordController(this._passwordService, this._localStorage);

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final token = localStorage.getToken();
      if (token == null) throw 'No token found';
      final response = await _passwordService.changePassword(
        accessToken: token,
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      log(response['message']);
      log("successssssssssssssssssssssssss-------------");

      return true;
    } catch (e) {
      if (e is ApiException) {
        log(e.message.toString());
        throw Exception(e.message);
      } else {
        log("unknown error : $e");

        throw Exception("Something went wrong");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword({required String email}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final token = localStorage.getToken();
      if (token == null) throw 'No token found';
      final response = await _passwordService.resetPassword(
        accessToken: token,
        email: email,
      );
      log(response['message']);
      log("successssssssssssssssssssssssss-------------");

      return true;
    } catch (e) {
      if (e is ApiException) {
        log(e.message.toString());

        throw Exception(e.message);
      } else {
        log("unknown error : $e");

        throw Exception("Something went wrong");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
