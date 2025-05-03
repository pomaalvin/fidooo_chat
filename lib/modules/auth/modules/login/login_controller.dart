import 'package:fidooo_chat/modules/auth/auth_controller.dart';
import 'package:fidooo_chat/modules/auth/interfaces/auth_repository.dart';
import 'package:fidooo_chat/modules/auth/models/user_app.dart';
import 'package:fidooo_chat/shared/services/alert_service.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_store.dart';

class LoginController {
  final LoginStore store;
  final alertService = Modular.get<AlertService>();
  final auth = Modular.get<AuthController>();
  final authRepository = Modular.get<AuthRepository>();
  final LocalStorageService localStorageService= Modular.get<LocalStorageService>();

  LoginController(this.store);

  Future<void> login() async {
    store.validateAll();
    if (store.errors.isNotEmpty) return;

    try {
      store.status=LoginStatus.loading;
      UserApp userApp = await authRepository.login(store.email, store.password);
      await localStorageService.saveToken(userApp.token);
      await localStorageService.saveUser(userApp.id);
      store.status=LoginStatus.normal;
      Modular.to.navigate('/chats/new');
    } catch (e) {
      store.status=LoginStatus.normal;
      if(e is FirebaseAuthException){
        return alertService.showError(e.message ?? "Ocurrio un error");
      }
      alertService.showError("Ocurrio un error");
    }
  }
}