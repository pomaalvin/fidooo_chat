import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:flutter/material.dart';

enum InputType { normal, password }

class AppInput extends StatefulWidget {
  final InputType type;
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextStyle? textStyle;
  final String? errorText;
  final Widget? suffixWidget;
  final Iterable<String>? autofillHints;

  const AppInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.textStyle,
    this.errorText,
    this.onSubmit,
    this.suffixWidget,
    this.type = InputType.normal,
    this.autofillHints
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool showText = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText:
          widget.type == InputType.password ? !showText : widget.obscureText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmit,
      autofillHints: widget.autofillHints,
      style:
          widget.textStyle ??
          const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: AppColorStyles.lightGrey),
        errorText: widget.errorText,
        fillColor: AppColorStyles.white,
        filled: true,


        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColorStyles.lightGrey50, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColorStyles.error, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusColor: AppColorStyles.white,
        hoverColor: AppColorStyles.white,
        suffixIcon:
            widget.type == InputType.password
                ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    showText
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                )
                : widget.suffixWidget,
      ),
    );
  }
}
