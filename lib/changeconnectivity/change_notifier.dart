import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class  ChangeConnectivity extends ChangeNotifier{
  ConnectivityResult? connectivityResult;

  void connectivityChange(ConnectivityResult result){
    if(result==ConnectivityResult.wifi){
      print('wifi');
    }
    else if(result==ConnectivityResult.mobile){
      print('mobile');
    }
    else if(result==ConnectivityResult.ethernet){
      print('ethernet');
      }
    else{
      print('something went wrong');
    }
    connectivityResult=result;
    notifyListeners();
  }

}