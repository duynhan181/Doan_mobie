import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RoundPlay userFromJson(String str) => RoundPlay.fromJson(json.decode(str));

class RoundPlay {
  RoundPlay({
    required this.uid,
    required this.name,
    required this.field,
    required this.date,
    required this.point,
  });
  String uid;
  String name;
  String field;
  Timestamp date;
  int point;

  factory RoundPlay.fromJson(Map<String, dynamic> json) => RoundPlay(
        uid: json["uid"],
        name: json["name"],
        field: json["field"],
        date: json["date"],
        point: json["point"],
      );

  
}
