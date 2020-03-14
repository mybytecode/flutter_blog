import 'package:connectivity/connectivity.dart';

class CheckInternetState
{
   Future<bool> check()async
  {
    bool state = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else {
      state=false;
    }
    return state;
  }
}