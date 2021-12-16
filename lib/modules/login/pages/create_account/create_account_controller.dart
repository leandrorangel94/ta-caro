// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ta_caro/shared/utils/state.dart';

class CreateAccountController extends ChangeNotifier {
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";

  void onChange({String? name, String? email, String? password}) {
    _name = name ?? _name;
    _email = email ?? _email;
    _password = password ?? _password;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        await Future.delayed(Duration(seconds: 3));
        update(AppState.success<String>("Deu certo"));
      } catch (e) {
        update(AppState.error("Não foi possivel criar conta"));
      }
    }
  }
}
