import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 200),
            InputText(label: 'E-mail', hint: 'Digite seu e-mail'),
            SizedBox(height: 18),
            InputText(label: 'Senha', hint: 'Digite sua senha'),
            SizedBox(height: 14),
            Button(
              onPressed: () {},
              label: 'Entrar',
              type: ButtonType.fill,
            ),
            SizedBox(height: 50),
            Button(
              onPressed: () {},
              label: 'Criar conta',
              type: ButtonType.outline,
            )
          ],
        ),
      ),
    );
  }
}
