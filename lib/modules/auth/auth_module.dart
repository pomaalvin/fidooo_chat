// ignore_for_file: unused_import

import 'package:fidooo_chat/modules/auth/auth_controller.dart';
import 'package:fidooo_chat/modules/auth/auth_store.dart';
import 'package:fidooo_chat/modules/auth/interfaces/auth_repository.dart';
import 'package:fidooo_chat/modules/auth/modules/login/login_controller.dart';
import 'package:fidooo_chat/modules/auth/modules/login/login_page.dart';
import 'package:fidooo_chat/modules/auth/modules/login/login_store.dart';
import 'package:fidooo_chat/modules/auth/repositories/firebase_auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module{
  @override
  void binds(Injector i) {
    i.addSingleton(LoginStore.new);
    i.addSingleton(()=>LoginController(i.get<LoginStore>()));
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
    r.child("/",child: (context) => LoginPage(),);
    super.routes(r);
  }
}