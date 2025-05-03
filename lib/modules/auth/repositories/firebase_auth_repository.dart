import 'package:fidooo_chat/modules/auth/interfaces/auth_repository.dart';
import 'package:fidooo_chat/modules/auth/models/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository{
  @override
  Future<UserApp> login(String email, String password) async{
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    String? token = await user.user?.getIdToken();
    if(token==null){
      throw Exception("Error token");
    }
    UserApp userApp = UserApp(
        id: user.user!.uid,
        token: token,
        name: user.user!.displayName ?? "",
        email: user.user!.email ?? ""
    );
    return userApp;
  }

  @override
  Future<UserApp?> getUser() async{
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken();
    if(token==null){
      return null;
    }
    UserApp userApp = UserApp(
        id: user!.uid,
        token: token,
        name: user.displayName ?? "",
        email: user.email ?? ""
    );
    return userApp;
  }

  @override
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }

}