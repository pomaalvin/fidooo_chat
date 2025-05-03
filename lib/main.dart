// ignore_for_file: unused_import

import 'package:fidooo_chat/core/app_module.dart';
import 'package:fidooo_chat/core/app_theme.dart';
import 'package:fidooo_chat/firebase_options.dart';
import 'package:fidooo_chat/modules/auth/auth_controller.dart';
import 'package:fidooo_chat/modules/auth/auth_store.dart';
import 'package:fidooo_chat/shared/constants/assets_keys.dart';
import 'package:fidooo_chat/shared/services/alert_service.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:fidooo_chat/shared/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: AssetsKeys.assetEnv);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var loading = true;
  @override
  void initState() {
    _checkLoginOnce();
    super.initState();
  }

  void _checkLoginOnce() async{
    await Modular.get<LocalStorageService>().init();
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final authStore = Modular.get<AuthStore>();
    return MaterialApp.router(
      title: 'Fidoo Chat',
      scaffoldMessengerKey: Modular.get<AlertService>().messengerKey,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: Modular.routerConfig,
      builder: (context, child) {
        return Observer(
          builder: (_) {
            return Stack(
              children: [
                child ?? Scaffold(),
                if (authStore.status == AuthStatus.init || loading) SplashScreen(),
              ],
            );
          },
        );
      },
    );
  }
}
