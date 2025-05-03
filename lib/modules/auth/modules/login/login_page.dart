import 'package:fidooo_chat/modules/auth/modules/login/login_controller.dart';
import 'package:fidooo_chat/modules/auth/modules/login/login_store.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:fidooo_chat/shared/styles/text_styles.dart';
import 'package:fidooo_chat/shared/widgets/app_button.dart';
import 'package:fidooo_chat/shared/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
class LoginPage extends StatelessWidget {
  final loginStore = Modular.get<LoginStore>();
  final loginController = Modular.get<LoginController>();
  LoginPage({super.key});


  Widget _loginForm(){
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Iniciar Sesión",style: AppTextStyles.title.copyWith(color: AppColorStyles.grey),textAlign: TextAlign.center,),
          const SizedBox( height: 24,),
          Observer(
            builder: (_) {
              return AppInput(
                hint: "Correo electrónico",
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  loginStore.setField("email", value);
                },
                autofillHints: const [AutofillHints.email],
                errorText: loginStore.errors["email"],
              );
            }
          ),
          const SizedBox( height: 16,),
          Observer(
              builder: (_) {
              return AppInput(
                hint: "Contraseña",
                type: InputType.password,
                onSubmit: (value){
                  loginController.login();
                },
                autofillHints: const [AutofillHints.password],
                onChanged: (value) {
                  loginStore.setField("password", value);
                },
                errorText: loginStore.errors["password"],
              );
            }
          ),
          const SizedBox( height: 16,),
          Observer(
            builder: (_) {
              return AppButton(
                  onTap: (){
                    loginController.login();
                  },
                  loading: loginStore.status==LoginStatus.loading,
                  text: "Iniciar Sesion"
              );
            }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
          left: 0,
          right: 0,child: Container(
            color: AppColorStyles.darkgrey,
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("assets/logo.png",height: 20,),
          )),
          Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: _loginForm(),
                  )
                ),
              )
          ),
        ],
      ),
    );
  }
}
