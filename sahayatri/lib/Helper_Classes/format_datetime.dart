import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dynamic formatDate(DateTime date) {
  return DateFormat('E, dd MMM').format(date);
}

dynamic formatTime(BuildContext context, TimeOfDay time) {
  return time.format(context);
}
