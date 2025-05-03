import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:flutter/material.dart';


enum ButtonSize{small,medium,large}
class AppButton extends StatelessWidget {
  final ButtonSize size;
  final VoidCallback onTap;
  final String text;
  final bool loading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.loading = false,
    this.backgroundColor = AppColorStyles.primary,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.size = ButtonSize.medium
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: backgroundColor.withValues(alpha: 0.2),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: _getPadding(),
            child: Center(
              child: loading
                  ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  strokeWidth: 2,
                ),
              )
                  : Text(
                text.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontSize: _getSize(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getPadding(){
    switch(size){

      case ButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 12, horizontal: 20);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(vertical: 14, horizontal: 20);
    }
  }
  double _getSize(){
    switch(size){

      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }
}