// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'login_store.g.dart';
enum LoginStatus { normal,loading }

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  LoginStatus status = LoginStatus.normal;

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  ObservableMap<String, String?> errors = ObservableMap.of({});

  @action
  void setField(String field, String value) {
    if (field == 'email') email = value;
    if (field == 'password') password = value;
    validateField(field, value);
  }

  @action
  void validateField(String field, String value) {
    switch (field) {
      case 'email':
        if (value.isEmpty) {
          errors['email'] = 'El correo es obligatorio';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          errors['email'] = 'Correo inválido';
        } else {
          errors.remove('email');
        }
        break;
      case 'password':
        if (value.isEmpty) {
          errors['password'] = 'La contraseña es obligatoria';
        } else if (value.length < 6) {
          errors['password'] = 'Mínimo 6 caracteres';
        } else {
          errors.remove('password');
        }
        break;
    }
  }

  @action
  void validateAll() {
    validateField('email', email);
    validateField('password', password);
  }
}
