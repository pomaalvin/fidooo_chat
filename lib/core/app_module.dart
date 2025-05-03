import 'dart:async';

import 'package:fidooo_chat/modules/auth/auth_controller.dart';
import 'package:fidooo_chat/modules/auth/auth_module.dart';
import 'package:fidooo_chat/modules/auth/auth_store.dart';
import 'package:fidooo_chat/modules/auth/interfaces/auth_repository.dart';
import 'package:fidooo_chat/modules/auth/repositories/firebase_auth_repository.dart';
import 'package:fidooo_chat/modules/chat/chat_module.dart';
import 'package:fidooo_chat/shared/services/alert_service.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:fidooo_chat/shared/utils/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  void binds(Injector i) async{



    i.add<LocalStorageService>(() => LocalStorageService.setup());
    i.addSingleton(()=>DioClient(i.get<LocalStorageService>()));

    i.addSingleton(AlertService.new);

    i.add<AuthRepository>(FirebaseAuthRepository.new);

    i.addSingleton(AuthStore.new);
    i.addSingleton(() => AuthController(i.get<AuthStore>(), i.get<AuthRepository>()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.redirect("/", to: "/chats/new");
    r.module("/auth", module: AuthModule(), guards: [AuthGuard()]);
    r.module("/chats", module: ChatModule(), guards: [NoAuthGuard()]);
    super.routes(r);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/chats/new');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async{
    await Modular.get<AuthController>().verify();
    return Modular.get<AuthStore>().status != AuthStatus.okAuth;
  }
}

class NoAuthGuard extends RouteGuard {
  NoAuthGuard() : super(redirectTo: '/auth/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async{
    await Modular.get<AuthController>().verify();
    return Modular.get<AuthStore>().status == AuthStatus.okAuth;
  }
}

