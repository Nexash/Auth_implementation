import 'package:flutter/material.dart';

//TODO: replace method with class
Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  bool obscure = false,
  bool isVisible = false,
  VoidCallback? onToggleVisibility,
  FocusNode? focusNode,
  bool autofocus = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    obscureText: obscure && !isVisible,
    autofocus: autofocus,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      //show hide password
      suffixIcon:
          obscure
              ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: onToggleVisibility,
              )
              : null,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
        ), // error but not focused
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey, width: 2), // keep grey
      ),
      errorStyle: const TextStyle(color: Colors.redAccent), // error text color
    ),

    validator: validator,
  );
}
