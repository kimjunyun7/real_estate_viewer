import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../getX/date_picker_controller.dart';

class MonthPickerModal {
  final _formKey = GlobalKey<FormState>();

  Widget generateBottomModal(BuildContext context) {
    final controller = Get.put(DatePickerController());
    return Obx(
      () => Container(
        color: Colors.greenAccent,
        // child: AnimatedSize(
        //   curve: Curves.easeInOut,
        //   // vsync: this,
        //   duration: const Duration(milliseconds: 300),
        child: SizedBox(
          height: 400.0,
          child: Column(
            children: [
              ...generateYearAndMonthPicker(controller, isStart: true),
              ...generateYearAndMonthPicker(controller, isStart: false),
              Form(
                key: _formKey,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.updateDateTime();
                      Fluttertoast.showToast(
                          msg: controller.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.amber[50],
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                    context.pop();
                    ////////////////////// 날짜 업뎃하면서 검색도 되게
                  },
                  child: const Text('검색'),
                ),
              ),
              Text(
                  '${controller.pickerStartYear.value}년 ${controller.pickerStartMonth.value}월'),
              Text(
                  '${controller.pickerEndYear.value}년 ${controller.pickerEndMonth.value}월'),
              Text('${controller.toString()} 날짜임'),
            ],
          ),
        ),
      ),
      //   ),
    );
  }

  List<Widget> generateYearAndMonthPicker(DatePickerController controller,
      {required bool isStart}) {
    int nowYear = DateTime.now().year;
    return [
      Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.updatePickerYears(
                  isStart: isStart,
                  year: isStart
                      ? controller.pickerStartYear.value - 1
                      : controller.pickerEndYear.value - 1);
            },
            onLongPress: () {
              controller.isLongPressing.value = true;

              controller.iterateFunction(() {
                log('year: ${controller.startYear.value}');
                controller.updatePickerYears(
                    isStart: isStart,
                    year: isStart
                        ? controller.pickerStartYear.value - 1
                        : controller.pickerEndYear.value - 1);
              });
            },
            onLongPressEnd: (_) {
              controller.isLongPressing.value = false;
            },
            child: Icon(
              Icons.navigate_before_rounded,
              size: 34.0,
              color: (isStart
                          ? controller.pickerStartYear.value
                          : controller.pickerEndYear.value) <=
                      DatePickerController.MIN_YEAR
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${isStart ? controller.pickerStartYear.value : controller.pickerEndYear.value}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.updatePickerYears(
                  isStart: isStart,
                  year: isStart
                      ? controller.pickerStartYear.value + 1
                      : controller.pickerEndYear.value + 1);
            },
            onLongPress: () {
              controller.isLongPressing.value = true;

              controller.iterateFunction(() {
                log('year: ${controller.startYear.value}');
                controller.updatePickerYears(
                    isStart: isStart,
                    year: isStart
                        ? controller.pickerStartYear.value + 1
                        : controller.pickerEndYear.value + 1);
              });
            },
            onLongPressEnd: (_) {
              controller.isLongPressing.value = false;
            },
            // onLongPressUp: () {controller.isLongPressing.value},
            child: Icon(
              Icons.navigate_next_rounded,
              size: 34.0,
              color: (isStart
                          ? controller.pickerStartYear.value
                          : controller.pickerEndYear.value) >=
                      nowYear
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     controller.updatePickerYears(
          //         isStart: isStart,
          //         year: isStart
          //             ? controller.pickerStartYear.value + 1
          //             : controller.pickerEndYear.value + 1);
          //   },
          //   icon: const Icon(Icons.navigate_next_rounded),
          // ),
        ],
      ),
      ...generateMonths(controller, isStart: isStart),
    ];
  }

  List<Widget> generateMonths(var controller, {required bool isStart}) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(1, 6, controller, isStart: isStart),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(7, 12, controller, isStart: isStart),
      ),
    ];
  }

  List<Widget> generateRowOfMonths(
      int from, int to, DatePickerController controller,
      {required bool isStart}) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      final backgroundColor = i.isEqual(isStart
              ? controller.pickerStartMonth.value
              : controller.pickerEndMonth.value)
          ? const Color.fromARGB(255, 255, 225, 133)
          : Colors.transparent;
      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: TextButton(
            key: ValueKey(backgroundColor),
            onPressed:
                // controller.pickerStartYear.value >
                //             controller.pickerEndYear.value &&
                //         isStart
                //     ? null
                //     : controller.pickerStartYear.value >
                //                 controller.pickerEndYear.value &&
                //             isStart
                //         ? null
                //         : controller.pickerStartYear.value ==
                //                     controller.pickerEndYear.value &&
                //                 ((isStart && controller.pickerEndMonth.value < i) ||
                //                     (!isStart &&
                //                         controller.pickerStartMonth.value > i))
                //             ? null :
                () {
              controller.updatePickerMonths(isStart: isStart, month: i);
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: const CircleBorder(),
            ),
            child: Text('$i월'),
          ),
        ),
      );
    }
    return months;
  }
}
