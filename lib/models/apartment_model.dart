// To parse this JSON data, do
//
//     final apartmentModel = apartmentModelFromJson(jsonString);

import 'dart:convert';

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
    required this.isHouseContractRenewed,
    required this.builtYear,
    required this.contractType,
    required this.contractTerm,
    required this.year,
    required this.dong,
    required this.depositAmount,
    required this.nameOfApartment,
    required this.month,
    required this.monthlyRentFee,
    required this.day,
    required this.ownArea,
    required this.depositOfRenew,
    required this.monthlyRentFeeOfRenew,
    required this.numberOfLandLot,
    required this.regionalCode,
    required this.floor,
  });

  final Renewed isHouseContractRenewed;
  final int builtYear;
  final Enum contractType;
  final String contractTerm;
  final int year;
  final String dong;
  final dynamic depositAmount;
  final String nameOfApartment;
  final int month;
  final int monthlyRentFee;
  final int day;
  final double ownArea;
  final String depositOfRenew;
  final dynamic monthlyRentFeeOfRenew;
  final String numberOfLandLot;
  final int regionalCode;
  final int floor;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        isHouseContractRenewed:
            emptyValues.map[json["갱신요구권사용"]] ?? Renewed.none,
        builtYear: json["건축년도"] ?? -1,
        contractType: enumValues.map[json["계약구분"]] ?? Enum.EMPTY,
        contractTerm: json["계약기간"] ?? 'null',
        year: json["년"] ?? -1,
        dong: json["법정동"] ?? 'null',
        depositAmount: json["보증금액"] ?? 'null',
        nameOfApartment: json["아파트"] ?? 'null',
        month: json["월"] ?? -1,
        monthlyRentFee: json["월세금액"] ?? -1,
        day: json["일"] ?? -1,
        ownArea: json["전용면적"]?.toDouble() ?? -1,
        depositOfRenew: json["종전계약보증금"] ?? 'null',
        monthlyRentFeeOfRenew: json["종전계약월세"] ?? -1,
        numberOfLandLot: json["지번"] ?? -1,
        regionalCode: json["지역코드"] ?? -1,
        floor: json["층"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "갱신요구권사용": emptyValues.reverse[isHouseContractRenewed],
        "건축년도": builtYear,
        "계약구분": enumValues.reverse[contractType],
        "계약기간": contractTerm,
        "년": year,
        "법정동": dong,
        "보증금액": depositAmount,
        "아파트": nameOfApartment,
        "월": month,
        "월세금액": monthlyRentFee,
        "일": day,
        "전용면적": ownArea,
        "종전계약보증금": depositOfRenew,
        "종전계약월세": monthlyRentFeeOfRenew,
        "지번": numberOfLandLot,
        "지역코드": regionalCode,
        "층": floor,
      };
}

enum Renewed { none, renewed }

final emptyValues = EnumValues({" ": Renewed.none, "사용": Renewed.renewed});

enum Enum { EMPTY, PURPLE, FLUFFY }

final enumValues =
    EnumValues({" ": Enum.EMPTY, "갱신": Enum.FLUFFY, "신규": Enum.PURPLE});

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
