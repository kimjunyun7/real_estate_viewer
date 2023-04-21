import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:real_estate_viewer/models/apartment_model.dart';

import '../config/constants.dart';

class ApiServices {
  /// 전체 아파트 확인
  /// return: Future<List<AccountModel>>
  Future<ApartmentModel> fetchAccountList() async {
    try {
      final header = {"Content-Type": "application/json"};

      var uri = Uri.parse(ApiConstants.baseUrl);
      final response = await http.get(uri, headers: header);

      if (response.statusCode == 200) {
        // log("전체 계좌 조회 확인: ${response.body}");
        log("전체 아파트 조회 성공");
        // log("account list: $list");

        return ApartmentModel.fromJson(jsonDecode(response.body));
      }
      log("전체 아파트 조회 Status: ${response.statusCode}");
      log("전체 아파트 조회 PostOUTOFIF: ${response.body}");
    } catch (e) {
      log('전체 아파트 조회: ${e.toString()}');
    }
    throw Exception('전체 아파트 조회 실패');
  }
}
