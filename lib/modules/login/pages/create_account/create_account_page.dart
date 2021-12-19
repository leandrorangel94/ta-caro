import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/pages/create_account/create_account_controller.dart';
import 'package:ta_caro/modules/login/repositories/login_repository_impl.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late CreateAccountController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = CreateAccountController(
      repository: LoginRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
          success: (value) => Navigator.pop(context),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
              (context) => BottomSheet(
                  onClosing: () {}, builder: (context) => Text(message))),
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        leading: BackButton(
          color: AppTheme.colors.backButton,
        ),
        elevation: 0,
      ),
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Criar uma conta",
                style: AppTheme.textStyles.title,
              ),
              SizedBox(height: 10),
              Text(
                "Mantenha seus gastos em dia",
                style: AppTheme.textStyles.subtitle,
              ),
              SizedBox(height: 38),
              InputText(
                label: 'Nome',
                hint: 'Digite seu nome',
                onChanged: (value) => controller.onChange(name: value),
                validator: (value) =>
                    value.isNotEmpty ? null : "Digite seu nome",
              ),
              SizedBox(height: 18),
              InputText(
                label: 'E-mail',
                hint: 'Digite seu e-mail',
                onChanged: (value) => controller.onChange(email: value),
                validator: (value) =>
                    isEmail(value) ? null : "Digite um e-mail válido!",
              ),
              SizedBox(height: 18),
              InputText(
                label: 'Senha',
                obscure: true,
                hint: 'Digite sua senha',
                onChanged: (value) => controller.onChange(password: value),
                validator: (value) => value.length > 5
                    ? null
                    : 'Digite uma senha que contenha mais que cinco caracteres',
              ),
              SizedBox(height: 14),
              AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                        loading: () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                        orElse: () => Button(
                          label: 'Criar conta',
                          type: ButtonType.fill,
                          onPressed: () {
                            controller.create();
                          },
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
