import 'package:flutter/material.dart';

datePicker(
    BuildContext context, StateSetter setState, DateTime datePicked) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: datePicked,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    selectableDayPredicate: (DateTime value) =>
        value.difference(DateTime.now()).inDays < 0 ||
                value.difference(DateTime.now()).inDays > 30
            ? false
            : true,
  );

  if (date != null) {
    setState(() {
      datePicked = date;
    });
  }
}

void timePicker(
    BuildContext context, StateSetter setState, TimeOfDay timePicked) async {
  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: timePicked,
  );

  if (time != null) {
    setState(() {
      timePicked = time;
    });
  }
}
