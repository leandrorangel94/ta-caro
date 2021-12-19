import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/login_controller.dart';
import 'package:ta_caro/modules/login/repositories/login_repository_impl.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = LoginController(
      repository: LoginRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
          success: (value) =>
              Navigator.pushNamed(context, "/home", arguments: value),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
              (context) => BottomSheet(
                  onClosing: () {}, builder: (context) => Text(message))),
          orElse: () {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 200),
              InputText(
                label: 'E-mail',
                hint: 'Digite seu e-mail',
                validator: (value) =>
                    isEmail(value) ? null : "Digite um e-mail válido!",
                onChanged: (value) => controller.onChange(email: value),
              ),
              SizedBox(height: 18),
              InputText(
                label: 'Senha',
                obscure: true,
                onChanged: (value) => controller.onChange(password: value),
                hint: 'Digite sua senha',
                validator: (value) =>
                    value.length > 5 ? null : "Digite uma senha mais forte!",
              ),
              SizedBox(height: 14),
              AnimatedBuilder(
                animation: controller,
                builder: (_, __) => controller.state.when(
                  loading: () => CircularProgressIndicator(),
                  orElse: () => Column(children: [
                    Button(
                      onPressed: () {
                        return controller.login();
                      },
                      label: 'Entrar',
                      type: ButtonType.fill,
                    ),
                    SizedBox(height: 50),
                    Button(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/login/create-account'),
                      label: 'Criar conta',
                      type: ButtonType.outline,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
