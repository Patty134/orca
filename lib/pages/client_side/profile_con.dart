import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:orca/data/model/auth.dart';
import 'package:orca/data/storage/user_Data.dart';

class ProfileCon extends GetxController {
  Future<Map<String, dynamic>> loadData() async {
    UserModel userModel = await UserStore().loadData();
    Map<String, dynamic> data = {};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.id)
          .get()
          .then((value) {
        data = value.data()!["preferences"];
      });
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message.toString());
    }

    return data;
  }
}
