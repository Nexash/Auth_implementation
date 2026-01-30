import 'package:auth_implementation/Utils/GlobalAccess/loading_helper.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(child: PulseImageLoader()),
          ),
        ),
  );
}
