
import 'package:flutter/cupertino.dart';

class ProvideRating extends ChangeNotifier{
  bool _rideCompleted = false;
  late int _driverId;

  bool get rideCompleted => _rideCompleted;
  int get driverId => _driverId;


  void provideRating({required int driverId}){
    _driverId = driverId;
    _rideCompleted = true;
    notifyListeners();
  }

  void ratingSubmitted(){
    _rideCompleted = false;
    notifyListeners();
  }
}