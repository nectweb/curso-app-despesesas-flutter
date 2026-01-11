import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeInput extends StatelessWidget {
  final String label;
  final TextEditingController inputController;
  final void Function() onPressed;
  final bool isValueNumber;
  const AdaptativeInput({
    super.key,
    required this.label,
    required this.isValueNumber,
    required this.onPressed,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            prefix: Text(label),
            controller: inputController,
            keyboardType: isValueNumber
                ? TextInputType.numberWithOptions()
                : null,
            onSubmitted: (_) => onPressed,
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: inputController,
            keyboardType: isValueNumber
                ? TextInputType.numberWithOptions()
                : null,
            onSubmitted: (_) => onPressed,
          );
  }
}
