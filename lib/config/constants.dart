/// 아파트 API 출처: https://www.data.go.kr/data/15058017/openapi.do#/tab_layer_detail_function
/// 주소 API 출처: https://juso.dev/docs/reg-code-api/

class ApiConstants {
  static const String baseUrl =
      'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage'
      '/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent';

  static const String regionBaseUrl =
      'https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes';

  ///string 타입, 검색하고자 하는 코드 패턴을 입력합니다.
  ///
  ///예를 들어 모든 특별/광역시(도)를 조회하려면 ```*00000000(10개)``` 파라메터를 입력합니다.
  static const String regionPattern = 'regcode_pattern=';

  ///boolean 타입, regcode_pattern 파라메터만 사용할 경우 발생하는 문제점을 해결하고자 추가된 파라메터입니다.
  ///
  ///예를 들어 종로구의 모든 동을 조회하려면 regcode_pattern 값이 ```1111*``` 형태를 띄게 될텐데 이 경우 서울특별시 종로구(1111000000)도 함께 조회가 됩니다.
  //
  ///
  ///종로구 그 자체가 아닌 종로구 소속만 조회하고 싶을 경우엔 is_ignore_zero 파라메터값을 ```true``` 로 설정하여 API를 호출합니다.
  static const String regionIsDetailOnly = 'is_ignore_zero=';
}
