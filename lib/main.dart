import 'package:app/core/bindings/application_bindings.dart';
import 'package:app/modules/funcionario/pages/funcionario/funcionario_bindings.dart';
import 'package:app/modules/funcionario/pages/funcionario/funcionario_page.dart';
import 'package:app/modules/login/pages/login/login_bindings.dart';
import 'package:app/modules/login/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        defaultTransition: Transition.native,
        initialBinding: ApplicationBinding(),
        getPages: [
/*           GetPage(
              name: "/",
              page: () => const LoginPage(),
              binding: LoginBindings()), */
          GetPage(
              name: "/",
              page: () => FuncionarioPage(),
              binding: FuncionarioBindings()),
        ],
      ),
    );
