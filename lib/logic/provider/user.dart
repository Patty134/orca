import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:orca/data/model/auth.dart';
import 'package:orca/data/storage/user_Data.dart';

class UserDataManager extends StateNotifier<UserModel> {
  UserDataManager() : super(UserModel());
  UserStore _userStore = UserStore();

  Future<UserModel> loadDataState() async {
    try {
      _userStore.loadData().then((value) {
        state = value;
      });
    } catch (e) {
      Get.snackbar("store error", e.toString());
      return UserModel();
    }
    return state;
  }

  Future<void> updateDataState(UserModel userModel) async {
    state = userModel;
    await _userStore.updateData(userModel);
  }

  Future<void> deleteDataState() async {
    state = UserModel();
    await _userStore.deleteData();
  }
}

final userStateProvider =
    StateNotifierProvider<UserDataManager, UserModel>((ref) {
  return UserDataManager();
});
