import 'package:ta_caro/modules/login/repositories/login_repository.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/app_database.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AppDatabase database;

  LoginRepositoryImpl(this.database);

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await database.login(
      email: email,
      password: password,
    );
    return response;
  }
}
