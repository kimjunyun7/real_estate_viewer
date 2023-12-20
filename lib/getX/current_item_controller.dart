import 'dart:developer';

import 'package:get/get.dart';

import '../models/apartment_response_model.dart';
import '../models/region_city_model.dart';
import '../models/region_gu_model.dart';
import '../services/api_services.dart';

///법정동코드는 총 10자리로 구성되어 있으며 규칙은 다음과 같습니다(출처).
///가장 앞의 두 자리: [시/도]
///그 다음 세 자리: [시/군/구]
///그 다음 세 자리: [읍/면/동]
///그 이후 나머지: [리]
///예를 들어 서울특별시의 코드는 1100000000 이며, 서울특별시에 속한 모든 구는 11???00000 형식을 띄고 있습니다.
///이 API는 이러한 코드체계의 특성을 이용하여 wildcard 구문을 지원하여 원하는 목록을 반환할 수 있습니다.
class CurrentItemController extends GetxController {
  // var cityController = Get.find<ApartmentListController>();
  // var guController = Get.find<GuController>();
  var city = RegionCity(code: '11', name: '서울특별시').obs; // 0, 1번째 글자
  var gu = RegionGu(code: '11', name: '종로구', city: '서울특별시').obs; // 2, 3번쨰 글자

  List<Apartment> fetchedApartmentList = <Apartment>[].obs;
  List<RegionGu> fetchedGuList = <RegionGu>[].obs;

  List<Apartment> get apartmentList {
    return fetchedApartmentList;
  }

  List<RegionGu> get guList {
    return fetchedGuList;
  }
  // set apartmentList(List<Apartment> list) => apartmentList = list;

  @override
  void onInit() {
    super.onInit();
    fetchApartmentList();
    fetchGuList();
  }

  Future<void> fetchApartmentList() async {
    log('current_item fetchItems() called');
    try {
      // show a loading indicator while fetching data
      fetchedApartmentList.clear();
      final response = await ApiServices().fetchApartmentList(
        regionCode: '${city.value.code}${gu.value.code}000000',
        month: '202301',
      );
      final list = response.response.body.items.item;
      fetchedApartmentList.addAll(list);
    } catch (e) {
      // handle errors
      log('fetchItems: $e');
    }
  }

  Future fetchGuList() async {
    try {
      final guList = await ApiServices().fetchGuRegionCodeList(city.value.code);
      fetchedGuList = guList;
      log('fetched first Gu: ${guList.first}');
    } catch (e) {
      log('fetchGuList: $e');
    }
  }

  Future<String> updateCity(RegionCity selectedRegion) async {
    log('current_item updateCity() called');
    RegionCity temp = RegionCity(
        code: selectedRegion.code.substring(0, 2), name: selectedRegion.name);
    city.value = temp;
    await fetchGuList();

    gu.value =
        RegionGu(code: '11', name: guList.first.name, city: guList.first.city);
    fetchApartmentList();

    return temp.name;
  }

  String updateGu(RegionGu selected) {
    String tempName = selected.name.split(' ').last;
    RegionGu temp = RegionGu(
        code: selected.code.substring(2, 4),
        name: tempName,
        city: selected.city);
    gu.value = temp;

    fetchApartmentList();

    return temp.name;
  }
}
