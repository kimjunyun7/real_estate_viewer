class RegionCity {
  RegionCity({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  factory RegionCity.fromJson(Map<String, dynamic> json) => RegionCity(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
  @override
  String toString() {
    return '$code - $name';
  }
}
