import 'package:supabase/supabase.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/app_database.dart';

class SupabaseDatabase implements AppDatabase {
  late final SupabaseClient client;

  SupabaseDatabase() {
    init();
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment("SUPABASEURL"),
      const String.fromEnvironment("SUPABASEKEY"),
    );
  }

  @override
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await client.auth.signUp(email, password);

    if (response.error == null) {
      final user = UserModel(email: email, name: name, id: response.user!.id);
      await createUser(user.copyWith());
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possivel criar conta");
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signIn(password: password, email: email);
    if (response.error == null) {
      final user = await getUser(response.user!.id);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possivel realizar login");
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.from("users").insert(user.toMap()).execute();
    if (response.error == null) {
      return user;
    } else {
      throw Exception("Não foi possível cadastrar o usuário");
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final response =
        await client.from("users").select().filter("id", "eq", id).execute();
    if (response.error == null) {
      final user = UserModel.fromMap(response.data[0]);
      return user;
    } else {
      throw Exception("Não foi possível buscar o usuário");
    }
  }
}