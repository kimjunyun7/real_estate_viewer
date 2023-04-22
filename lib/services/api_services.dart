import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:real_estate_viewer/do_not_share.dart';
import 'package:real_estate_viewer/models/apartment_model.dart';

import '../config/constants.dart';

class ApiServices {
  /// 전체 아파트 확인
  /// return: Future<List<AccountModel>>
  Future<ApartmentModel> fetchApartmentList() async {
    try {
      final header = {
        "Accept": "application/json",
        "Content-type": "application/json",
      };
      String apiKey = DoNotShare().apiKey;

      var uri = Uri.parse(
          '${ApiConstants.baseUrl}?serviceKey=$apiKey&LAWD_CD=${"11110"}&DEAL_YMD=${"202201"}');
      log('url: $uri');
      final response = await http.get(uri, headers: header);
      final result =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      log('response: \n$result');

      if (response.statusCode == 200) {
        log("전체 아파트 조회 성공");

        return ApartmentModel.fromJson(result);
      }
      log("전체 아파트 조회 Status: ${response.statusCode}");
      log("전체 아파트 조회 PostOUTOFIF: ${response.body}");
    } catch (e) {
      log('전체 아파트 조회: ${e.toString()}');
    }
    throw Exception('전체 아파트 조회 실패');
  }
}
