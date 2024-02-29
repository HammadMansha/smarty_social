import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<ConnectivityResult> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }

  static Future<bool> isConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> isMobileConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile;
  }

  static Future<bool> isWifiConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi;
  }

  static Future<bool> isEthernetConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.ethernet;
  }

  static Future<bool> isVpnConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.vpn;
  }

  static Future<bool> isBluetoothConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.bluetooth;
  }

  static Future<bool> isOtherConnected() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult == ConnectivityResult.other;
  }
}
