import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca/pages/connectivity.dart';
import 'package:orca/pages/home/home_c.dart';

class NetworkController extends GetxController {
  BuildContext? context;

  NetworkController({this.context});

  final Connectivity _connectivity = Connectivity();

  bool firstStateNetwork = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.first == ConnectivityResult.none) {
      firstStateNetwork = true;
      Get.to(() => ConnectivityPage(), transition: Transition.fade);
      snackBar("network Offline", true);
    } else {
      Get.back();

      firstStateNetwork ? snackBar("Back Online", false) : null;
    }
  }

  Future<void> checkConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    _updateConnectionStatus(connectivityResult);
  }

  void snackBar(String text, bool isOnline) {
    Get.snackbar("Connection status", text,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor:
            !isOnline ? const Color.fromARGB(255, 32, 32, 32) : Colors.black87,
        margin: EdgeInsets.only(bottom: 10, right: 5, left: 5));
  }
}
