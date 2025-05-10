import 'package:flutter/material.dart';

import '../utils/app_constance.dart';

Future<DateTime?> showDatePickerDialog(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppConstance.primaryColor, // Header background color
            onPrimary: Colors.white, // Header text color
            onSurface: Colors.black, // Body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppConstance.primaryColor, // Button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return selectedDate;
}
