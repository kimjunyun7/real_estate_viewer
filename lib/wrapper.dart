import 'package:flutter/material.dart';
import 'package:real_estate_viewer/screens/home_screen.dart';
import 'package:real_estate_viewer/services/api_services.dart';
import 'package:real_estate_viewer/widgets/errors.dart';

import 'models/region_city_model.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late Future<List<RegionCity>> futureRegionCodeList;

  @override
  void initState() {
    super.initState();
    futureRegionCodeList = ApiServices().fetchCityRegionCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        futureRegionCodeList,
      ]),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Errors.showFutureError();
        } else {
          final result = snapshot.data ?? [];

          List<RegionCity> regionCodeList = result[0];

          return HomeScreen(regionCodeList: regionCodeList);
        }
      },
    );
  }
}
