import 'dart:async';

import 'package:fidooo_chat/modules/auth/auth_store.dart';
import 'package:fidooo_chat/modules/auth/interfaces/auth_repository.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthController {
  final AuthStore store;
  final AuthRepository authRepository;
  final LocalStorageService localStorageService= Modular.get<LocalStorageService>();

  AuthController(this.store,this.authRepository);

  Future<void> verify() async {
    try{
      store.status = AuthStatus.init;
      store.user = await authRepository.getUser();
      if(store.user!=null){
        store.status = AuthStatus.okAuth;
      }
      else{
        store.status = AuthStatus.noAuth;
      }
    }
    catch(e){
      store.status = AuthStatus.noAuth;
    }
  }

  logout()async{
    await authRepository.logout();
    await localStorageService.clearToken();
    await localStorageService.clearUser();
    Modular.to.navigate('/auth/');
  }
}