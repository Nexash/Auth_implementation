import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool autofocus;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  // final VoidCallback? onSubmitted;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.autofocus = false,
    required this.controller,
    this.validator,
    required this.focusNode,
    this.nextFocusNode,
    // this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isVisible = false; // for password toggle
  late FocusNode? _focusNode;
  late FocusNode? _nextFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode;
    _nextFocusNode = widget.nextFocusNode;
    _isVisible = !widget.obscure; // visible if not obscure
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: widget.obscure && !_isVisible,
      autofocus: widget.autofocus,
      validator: widget.validator,

      // textInputAction:
      //     widget.nextFocusNode != null
      //         ? TextInputAction.next
      //         : TextInputAction.done,
      onFieldSubmitted: (_) {
        final scope = FocusScope.of(context);
        if (_nextFocusNode != null) {
          scope.requestFocus(_nextFocusNode);
        } else {
          _focusNode?.unfocus();
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        suffixIcon:
            widget.obscure
                ? IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
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
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
