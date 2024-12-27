import 'package:orca/data/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  late final Future<SharedPreferences> _prefsFuture;

  UserStore() {
    _prefsFuture = SharedPreferences.getInstance();
  }

  Future<UserModel> loadData() async {
    final prefs = await _prefsFuture;
    return UserModel(
      name: prefs.getString('name') ?? "",
      email: prefs.getString('email') ?? "",
      phone: prefs.getString('phone') ?? "",
      id: prefs.getString('id') ?? "",
      image: prefs.getString('image') ?? "",
    );
  }

  Future<void> updateData(UserModel userModel) async {
    final prefs = await _prefsFuture;
    await prefs.setString('name', userModel.name ?? "");
    await prefs.setString('email', userModel.email ?? "");
    await prefs.setString('phone', userModel.phone ?? "");
    await prefs.setString('id', userModel.id ?? "");
    await prefs.setString('image', userModel.image ?? "");
  }

  Future<void> deleteData() async {
    final prefs = await _prefsFuture;
    await prefs.clear();
  }
}
