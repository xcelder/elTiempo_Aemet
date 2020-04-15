import '../values/Provinces.dart';

class Province {
  final Provinces provinceType;
  final String oldCode;
  final String code;
  final String name;

  Province(this.provinceType, this.oldCode, this.code, this.name);
}