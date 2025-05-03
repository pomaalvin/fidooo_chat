import 'package:fidooo_chat/modules/auth/models/user_app.dart';

abstract class AuthRepository{
  Future<UserApp> login(String email,String password);
  Future<void> logout();
  Future<UserApp?> getUser();
}