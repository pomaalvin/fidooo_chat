import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColorStyles.primary,),
      ),
    );
  }
}
