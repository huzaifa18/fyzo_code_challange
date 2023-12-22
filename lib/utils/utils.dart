
import 'package:flutter/cupertino.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

bool isBirthdayToday(DateTime dateToCheck){
  final date = DateTime(dateToCheck.month, dateToCheck.day);
  if(date == DateTime(DateTime.now().month, DateTime.now().day)) {
    return true;
  } else {
    return false;
  }
}