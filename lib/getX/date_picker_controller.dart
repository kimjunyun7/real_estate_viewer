import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController {
  // ignore: constant_identifier_names
  static const MIN_YEAR = 2000;

  Timer? _timer;
  int number = 0;
  final time = '00.00'.obs;

  var pickerStartYear = 2020.obs;
  var pickerStartMonth = DateTime.now().month.obs;
  var pickerEndYear = DateTime.now().year.obs;
  var pickerEndMonth = DateTime.now().month.obs;

  var startYear = DateTime.now().year.obs;
  var endYear = DateTime.now().year.obs;
  var startMonth = DateTime.now().month.obs;
  var endMonth = DateTime.now().month.obs;

  var isLongPressing = false.obs;

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void iterateFunction(VoidCallback function) {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      log('isLongPressing: ${isLongPressing.value}, year: ${pickerStartYear.value}');
      function();
      if (!isLongPressing.value) _timer?.cancel();
    });
    // while (isLongPressing.value) {
    //   log('isLongPressing: ${isLongPressing.value}');
    //   function;
    // }
  }

  void endIteration() {
    _timer?.cancel();
  }

  void updatePickerYears({required int year, required bool isStart}) {
    var now = DateTime.now().year;
    if (MIN_YEAR <= year && year <= now) {
      isStart ? pickerStartYear.value = year : pickerEndYear.value = year;
    }
  }

  void updatePickerMonths({required int month, required bool isStart}) {
    isStart ? pickerStartMonth.value = month : pickerEndMonth.value = month;
  }

  void correctPickers() {
    pickerStartYear.value = startYear.value;
    pickerEndYear.value = endYear.value;
    pickerStartMonth.value = startMonth.value;
    pickerEndMonth.value = endMonth.value;
  }

  void updateDateTime() {
    if (!verifyDate()) {
      Fluttertoast.showToast(
        msg: '날짜를 확인해주세요!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber[50],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }
    updateYears(true);
    updateYears(false);
    updateMonths(true);
    updateMonths(false);
  }

  bool verifyDate() {
    if (pickerStartYear.value > pickerEndYear.value) return false;
    if (pickerStartYear == pickerEndYear &&
        pickerStartMonth.value > pickerEndMonth.value) return false;
    return true;
  }

  void updateYears(bool isStart) {
    isStart
        ? startYear.value = pickerStartYear.value
        : endYear.value = pickerEndYear.value;
  }

  void updateMonths(bool isStart) {
    isStart
        ? startMonth.value = pickerStartMonth.value
        : endMonth.value = pickerEndMonth.value;
  }

  @override
  String toString() {
    return '$startYear-$startMonth ~ $endYear-$endMonth';
  }
}
