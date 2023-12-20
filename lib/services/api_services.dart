import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:real_estate_viewer/do_not_share.dart';
import 'package:real_estate_viewer/models/apartment_response_model.dart';
import 'package:real_estate_viewer/models/region_city_model.dart';

import '../config/constants.dart';
import '../models/region_gu_model.dart';

class ApiServices {
  Future<List<RegionCity>> fetchCityRegionCodeList() async {
    try {
      final header = {
        "Accept": "application/json",
        "Content-type": "application/json",
      };

      var uri = Uri.parse(
        '${ApiConstants.regionBaseUrl}'
        '?${ApiConstants.regionPattern}*00000000&${ApiConstants.regionIsDetailOnly}true',
      );

      final response = await http.get(uri, headers: header);

      if (response.statusCode == 200) {
        log("대한민국 시 조회 성공", name: 'API');
        List<RegionCity> list = [];
        for (var region in jsonDecode(
            const Utf8Decoder().convert(response.bodyBytes))['regcodes']) {
          list.add(RegionCity.fromJson(region));
        }

        return list;
      }
      log("대한민국 시 조회 Status: ${response.statusCode}", name: 'API');
      log("대한민국 시 조회 PostOUTOFIF: ${response.body}", name: 'API');
    } catch (e) {
      log('대한민국 시 조회: ${e.toString()}', name: 'API');
    }
    throw Exception('대한민국 시 조회 실패');
  }

  /// 각 행정구역의 코드를 받아 해당 지역의 구 리스트를 반환
  /// cityCode: 두자리 정수
  ///
  /// 1100000000(서울특별시)를 입력시, 1111000000(종로구) 등의 값들이 반환됨.
  Future<List<RegionGu>> fetchGuRegionCodeList(String cityCode) async {
    try {
      final header = {
        "Accept": "application/json",
        "Content-type": "application/json",
      };

      var uri = Uri.parse(
        '${ApiConstants.regionBaseUrl}'
        '?${ApiConstants.regionPattern}$cityCode*000000&${ApiConstants.regionIsDetailOnly}true',
      );

      final response = await http.get(uri, headers: header);

      if (response.statusCode == 200) {
        log("구 조회 성공", name: 'API');
        List<RegionGu> list = [];
        for (var region in jsonDecode(
            const Utf8Decoder().convert(response.bodyBytes))['regcodes']) {
          RegionCity temp = RegionCity.fromJson(region);
          list.add(RegionGu(
              code: temp.code,
              name: temp.name.split(' ').last,
              city: temp.name.split(' ').first));
        }

        return list;
      }
      log("구 조회 Status: ${response.statusCode}", name: 'API');
      log("구 조회 PostOUTOFIF: ${response.body}", name: 'API');
    } catch (e) {
      log('구 조회: ${e.toString()}', name: 'API');
    }
    throw Exception('구 조회 실패');
  }

  /// 전체 아파트 확인
  /// return: Future<List<AccountModel>>
  Future<ApartmentResponseModel> fetchApartmentList({
    required String regionCode,
    required String month,
  }) async {
    String regionCodeInFive = regionCode.substring(0, 5);
    try {
      final header = {
        "Accept": "application/json",
        "Content-type": "application/json",
      };
      String apiKey = DoNotShare().apiKey;

      var uri = Uri.parse(
          '${ApiConstants.baseUrl}?serviceKey=$apiKey&LAWD_CD=$regionCodeInFive&DEAL_YMD=$month');
      final response = await http.get(uri, headers: header);
      final result =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));

      if (response.statusCode == 200) {
        log("전체 아파트 조회 성공", name: 'API');
        return ApartmentResponseModel.fromJson(result);
      }
      log("전체 아파트 조회 Status: ${response.statusCode}", name: 'API');
      log("전체 아파트 조회 PostOUTOFIF: ${response.body}", name: 'API');
    } catch (e) {
      log('전체 아파트 조회: ${e.toString()}', name: 'API');
    }
    throw Exception('전체 아파트 조회 실패');
  }
}
