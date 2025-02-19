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
      identity: prefs.getString('identity') ?? "",
      name: prefs.getString('name') ?? "",
      email: prefs.getString('email') ?? "",
      phone: prefs.getString('phone') ?? "",
      id: prefs.getString('id') ?? "",
      image: prefs.getString('image') ?? "",
      description: prefs.getString('description') ?? "",
    );
  }

  Future<void> updateData(UserModel userModel) async {
    final prefs = await _prefsFuture;
    await prefs.setString('identity', userModel.identity ?? "");
    await prefs.setString('name', userModel.name ?? "");
    await prefs.setString('email', userModel.email ?? "");
    await prefs.setString('phone', userModel.phone ?? "");
    await prefs.setString('id', userModel.id ?? "");
    await prefs.setString('image', userModel.image ?? "");
    await prefs.setString('description', userModel.description ?? "");
  }

  Future<void> deleteData() async {
    final prefs = await _prefsFuture;
    await prefs.clear();
  }
}
