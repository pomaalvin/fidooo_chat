// ignore_for_file: library_private_types_in_public_api, unused_import

import 'package:fidooo_chat/modules/auth/models/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';
enum AuthStatus {okAuth, noAuth, init}

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  AuthStatus status = AuthStatus.init;

  @observable
  UserApp? user;
}