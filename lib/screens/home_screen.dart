import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_viewer/getX/current_item_controller.dart';
import 'package:real_estate_viewer/getX/date_picker_controller.dart';
import 'package:real_estate_viewer/models/apartment_response_model.dart';
import 'package:real_estate_viewer/models/enums/enums.dart';
import 'package:real_estate_viewer/models/region_city_model.dart';
import 'package:real_estate_viewer/widgets/month_picker_modal.dart';

import '../models/region_gu_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.regionCodeList,
  });

  final List<RegionCity> regionCodeList;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RegionCity initialCity;

  @override
  void initState() {
    super.initState();
    initialCity = widget.regionCodeList[0];
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(ApartmentListController());
    // Get.put(GuController());
    final currentItemController = Get.put(CurrentItemController());
    final datePickerController = Get.put(DatePickerController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        bottomNavigationBar:
            buildBottomNavigationBar(context, currentItemController),
        body: currentItemController.apartmentList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            Text('${currentItemController.city.value}'),
                            Text(
                                '${datePickerController.startYear}-${datePickerController.startMonth} ~ ${datePickerController.endYear}-${datePickerController.endMonth}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: height,
                        child: ListView.builder(
                          itemCount: currentItemController.apartmentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildApartmentItemList(
                                currentItemController.apartmentList[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildBottomNavigationBar(
      BuildContext context, CurrentItemController currentItemController) {
    RegionCity city = currentItemController.city.value;
    RegionGu gu = currentItemController.gu.value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                buildFilterDialog(
                  context,
                  title: '지역',
                  list: widget.regionCodeList,
                  controller: currentItemController,
                  itemType: DialogItemType.city,
                );
              },
              child: Text(city.name),
            ),
          ),
          const SizedBox(width: 14.0),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                setState(() {});
                buildFilterDialog(
                  context,
                  title: '구',
                  list: currentItemController.guList,
                  controller: currentItemController,
                  itemType: DialogItemType.gu,
                );
              },
              child: Text(gu.name),
            ),
          ),
          const SizedBox(width: 14.0),
          Flexible(
            flex: 1,
            child:
                // TextFormField(
                //   onTap: () {
                //     datePickerController.clickDatePicker(true);
                //   },
                //   initialValue: DateFormat("yyyy-MM-dd")
                //       .format(datePickerController.dateRange.value.start),
                // ),
                ElevatedButton(
              onPressed:
                  // datePickerController.clickDatePicker(true);
                  showMonthPicker
              // buildFilterDialog(
              //   context,
              //   title: '날짜',
              //   list: currentItemController.guList,
              //   controller: currentItemController,
              //   itemType: DialogItemType.gu,
              // );
              ,
              child: const Text('날짜'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApartmentItemList(Apartment item) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                  '${item.dong}, ${item.numberOfLandLot}, ${item.nameOfApartment}'),
              subtitle: Text(
                  '건축연도: ${item.builtYear}년 | 전용면적: ${item.ownArea} | 층: ${item.floor}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Row(children: [Expanded(child: Text('ID: ${item.id}'))]),
                  Row(children: [
                    Expanded(child: Text('보증금: ${item.depositAmount}만'))
                  ]),
                  Row(children: [
                    Expanded(child: Text('월세: ${item.monthlyRentFee}만'))
                  ]),
                  const SizedBox(height: 10.0),
                  Row(children: [
                    Expanded(child: Text('계약구분: ${(item.contractType)}'))
                  ]),
                  Row(children: [
                    Expanded(child: Text('기간: ${item.contractTerm}'))
                  ]),
                  // const SizedBox(height: 10.0),
                  // Row(children: [
                  //   Expanded(child: Text('보증금: ${item.depositAmount}만'))
                  // ]),
                  // Row(children: [
                  //   Expanded(child: Text('월세: ${item.monthlyRentFee}'))
                  // ]),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void buildFilterDialog(
    BuildContext context, {
    required String title,
    required List<dynamic> list,
    required CurrentItemController controller,
    required DialogItemType itemType,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 400.0,
          width: 300.0,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: ListTile(
                  title: Text(list[i].toString()),
                ),
                onTap: () {
                  updateDialogItem(controller, list[i], itemType);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String updateDialogItem(CurrentItemController controller, dynamic selected,
      DialogItemType itemType) {
    switch (itemType) {
      case DialogItemType.city:
        log('지역(city) 업데이트 - ${selected.name}', name: 'home');
        return controller.updateCity(selected).toString();
      case DialogItemType.gu:
        log('구(gu) 업데이트 - ${selected.name}', name: 'home');
        return controller.updateGu(selected).toString();
      case DialogItemType.date:
        return 'Error';
    }
  }

  showMonthPicker() {
    DatePickerController().correctPickers();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) =>
            MonthPickerModal().generateBottomModal(context));
  }

  // void showMonthPicker() {
  //   int selectedStartYear = DatePickerController().startYear.value;
  //   int selectedEndYear = DatePickerController().endYear.value;
  //   // showDialog(
  //   //     context: context,
  //   //     builder: (BuildContext context) {
  //   //       return const MonthPickerDialog();
  //   //     });
  //   // showModalBottomSheet(
  //   //     context: context,
  //   //     builder: (BuildContext context) => );
  //   Get.bottomSheet(
  //     GestureDetector(
  //     onTap: () {
  //       Navigator.pop(context);
  //       // widget.onTap();
  //     },
  //     child: Obx(
  //       () => Scaffold(
  //         backgroundColor: Colors.transparent,
  //         bottomNavigationBar: SizedBox(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           child: Container(
  //             color: Colors.greenAccent,
  //             child: AnimatedSize(
  //               curve: Curves.easeInOut,
  //               // vsync: this,
  //               duration: const Duration(milliseconds: 300),
  //               child: SizedBox(
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Column(
  //                   children: [
  //                     ...generateMonthPicker(DatePickerController(), selectedStartYear, selectedEndYear,
  //                         isStart: true),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   )
  //   );
  // }

  // }

  // List<Widget> generateMonthPicker(var datePickerController, int startYear, int endYear,
  //         {bool isStart = true}) =>
  //     [
  //       Row(
  //         children: [
  //           IconButton(
  //             onPressed: () {
  //                 startYear = startYear - 1;

  //             },
  //             icon: const Icon(Icons.navigate_before_rounded),
  //           ),
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 startYear.toString(),
  //                 style: const TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: () {
  //                 startYear = startYear + 1;
  //             },
  //             icon: const Icon(Icons.navigate_next_rounded),
  //           ),
  //         ],
  //       ),
  //       ...generateMonths(startYear,isStart: true),
  //       ElevatedButton(
  //           onPressed: () {
  //             datePickerController.updateYears(startYear, isStart: true);
  //           },
  //           child: const Text('필터')),
  //     ];

  //     List<Widget> generateMonths(int selectedYear, {bool isStart = true}) {
  //   return [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: generateRowOfMonths(1, 6, selectedYear, isStart: isStart),
  //     ),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: generateRowOfMonths(7, 12, isStart: isStart),
  //     ),
  //   ];
  // }

  // List<Widget> generateRowOfMonths(int from, int to, {bool isStart = true}) {
  //   List<Widget> months = [];
  //   for (int i = from; i <= to; i++) {
  //     DateTime dateTime = DateTime(_pickerYear, i, 1);
  //     final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth)
  //         ? Colors.amber
  //         : Colors.transparent;
  //     months.add(
  //       AnimatedSwitcher(
  //         duration: kThemeChangeDuration,
  //         transitionBuilder: (Widget child, Animation<double> animation) {
  //           return FadeTransition(
  //             opacity: animation,
  //             child: child,
  //           );
  //         },
  //         child: TextButton(
  //           key: ValueKey(backgroundColor),
  //           onPressed: () {
  //             setState(() {
  //               _selectedMonth = dateTime;
  //             });
  //           },
  //           style: TextButton.styleFrom(
  //             backgroundColor: backgroundColor,
  //             shape: const CircleBorder(),
  //           ),
  //           child: Text(
  //             DateFormat('MMM').format(dateTime),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return months;
  // }
}
