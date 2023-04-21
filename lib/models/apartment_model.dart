// To parse this JSON data, do
//
//     final apartmentModel = apartmentModelFromJson(jsonString);

class ApartmentModel {
  ApartmentModel({
    required this.response,
  });

  final Response response;

  factory ApartmentModel.fromJson(Map<String, dynamic> json) => ApartmentModel(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  Response({
    required this.header,
    required this.body,
  });

  final Header header;
  final Body body;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.items,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
  });

  final Items items;
  final int numOfRows;
  final int pageNo;
  final int totalCount;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        items: Items.fromJson(json["items"]),
        numOfRows: json["numOfRows"],
        pageNo: json["pageNo"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "items": items.toJson(),
        "numOfRows": numOfRows,
        "pageNo": pageNo,
        "totalCount": totalCount,
      };
}

class Items {
  Items({
    required this.item,
  });

  final List<Item> item;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.empty,
    required this.item,
    required this.purple,
    required this.fluffy,
    required this.tentacled,
    required this.sticky,
    required this.indigo,
    required this.indecent,
    required this.hilarious,
    required this.ambitious,
    required this.cunning,
    required this.magenta,
    required this.frisky,
    required this.mischievous,
    required this.braggadocious,
    required this.the1,
    required this.the2,
  });

  final Empty empty;
  final int item;
  final Enum purple;
  final String fluffy;
  final int tentacled;
  final String sticky;
  final dynamic indigo;
  final String indecent;
  final int hilarious;
  final int ambitious;
  final int cunning;
  final double magenta;
  final String frisky;
  final dynamic mischievous;
  final dynamic braggadocious;
  final int the1;
  final int the2;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        empty: emptyValues.map[json["갱신요구권사용"]]!,
        item: json["건축년도"],
        purple: enumValues.map[json["계약구분"]]!,
        fluffy: json["계약기간"],
        tentacled: json["년"],
        sticky: json["법정동"],
        indigo: json["보증금액"],
        indecent: json["아파트"],
        hilarious: json["월"],
        ambitious: json["월세금액"],
        cunning: json["일"],
        magenta: json["전용면적"]?.toDouble(),
        frisky: json["종전계약보증금"],
        mischievous: json["종전계약월세"],
        braggadocious: json["지번"],
        the1: json["지역코드"],
        the2: json["층"],
      );

  Map<String, dynamic> toJson() => {
        "갱신요구권사용": emptyValues.reverse[empty],
        "건축년도": item,
        "계약구분": enumValues.reverse[purple],
        "계약기간": fluffy,
        "년": tentacled,
        "법정동": sticky,
        "보증금액": indigo,
        "아파트": indecent,
        "월": hilarious,
        "월세금액": ambitious,
        "일": cunning,
        "전용면적": magenta,
        "종전계약보증금": frisky,
        "종전계약월세": mischievous,
        "지번": braggadocious,
        "지역코드": the1,
        "층": the2,
      };
}

enum Empty { empty, purple }

final emptyValues = EnumValues({" ": Empty.empty, "사용": Empty.purple});

enum Enum { empty, purple, fluffy }

final enumValues =
    EnumValues({" ": Enum.empty, "갱신": Enum.fluffy, "신규": Enum.purple});

class Header {
  Header({
    required this.resultCode,
    required this.resultMsg,
  });

  final String resultCode;
  final String resultMsg;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        resultCode: json["resultCode"],
        resultMsg: json["resultMsg"],
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "resultMsg": resultMsg,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
