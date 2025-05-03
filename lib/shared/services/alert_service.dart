// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alert_service.g.dart';

class AlertService = _AlertService with _$AlertService;

abstract class _AlertService with Store {

  @action
  void showSuccess(String message) {
    _showSnackBar(message, color: Colors.green);
  }

  @action
  void showError(String message) {
    _showSnackBar(message, color: Colors.red);
  }

  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  void _showSnackBar(String message, {Color color = Colors.black}) {
    messengerKey.currentState?.clearSnackBars();
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}