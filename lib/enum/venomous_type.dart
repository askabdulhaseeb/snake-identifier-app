import 'package:flutter/material.dart';

enum VenomousLevel {
  dangerouslyVenomous('dangerous', 'Dangerously Venomous', Colors.red),
  mildlyVenomous('mildle', 'Mildly Venomous', Colors.deepOrange),
  cautionVenomous('caution', 'Caution Venomous', Colors.orange),
  venomous('venomous', 'Venomous', Colors.blue),
  nonVenomous('non_venomous', 'Non Venomous', Colors.green);

  const VenomousLevel(this.json, this.title, this.color);
  final String json;
  final String title;
  final Color color;
}

class VenomousLevelConvertor {
  VenomousLevel toEnum(String level) {
    if (level == VenomousLevel.dangerouslyVenomous.json) {
      return VenomousLevel.dangerouslyVenomous;
    } else if (level == VenomousLevel.mildlyVenomous.json) {
      return VenomousLevel.mildlyVenomous;
    } else if (level == VenomousLevel.cautionVenomous.json) {
      return VenomousLevel.cautionVenomous;
    } else if (level == VenomousLevel.venomous.json) {
      return VenomousLevel.venomous;
    } else {
      return VenomousLevel.nonVenomous;
    }
  }
}
