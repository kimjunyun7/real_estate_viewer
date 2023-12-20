class RegionGu {
  RegionGu({
    required this.code,
    required this.name,
    required this.city,
  });

  final String code;
  final String name;
  final String city;

  factory RegionGu.fromJson(Map<String, dynamic> json) => RegionGu(
        code: json["code"],
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "city": city,
      };
  @override
  String toString() {
    return '$code $city - $name';
  }
}
