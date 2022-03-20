import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dynamic formatDate(DateTime date) {
  return DateFormat('E, dd MMM').format(date);
}

dynamic formatTime(BuildContext context, TimeOfDay time) {
  return time.format(context);
}

dynamic stringToTime(BuildContext context, String time){
  String subString = time.substring(10, 15);
  return TimeOfDay(hour:int.parse(subString.split(":")[0]),minute: int.parse(subString.split(":")[1])).format(context);
}
