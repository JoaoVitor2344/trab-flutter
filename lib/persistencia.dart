import 'package:shared_preferences/shared_preferences.dart';

const nomeKey = "nomeKey";
const emailKey = "emailKey";
const senhaKey = "senhaKey";
const stringListKey = "stringListKey";

class LocalDate {
  static salvarString(String nome, String email, String senha) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setString(nomeKey, nome);
    shared.setString(emailKey, email);
    shared.setString(senhaKey, senha);
  }

  static salvarListaString(List<String> lista) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setStringList(stringListKey, lista);
  }

  static Future<String> getString(String key) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    switch (key) {
      case "nome":
        return shared.getString(nomeKey) ?? "";
      case "email":
        return shared.getString(emailKey) ?? "";
      case "senha":
        return shared.getString(senhaKey) ?? "";
      default:
        return "Vazio";
    }
  }

  static Future<List<String>> getListString(String s) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getStringList(stringListKey) ?? [];
  }
}
