import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));



class Question {
  Question({
    required this.idQuestion,
    required this.content,
    required this.answer,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.field,

  });

  String idQuestion;
  String content;
  String answer;
  String a;
  String b;
  String c;
  String d;
  String field;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        idQuestion: json["id_question"] ?? "",
        content: json["content"] ?? "",
        answer: json["answer"] ?? "",
        a: json["a"] ?? "",
        b: json["b"] ?? "",
        c: json["c"] ?? "",
        d: json["d"] ?? "",
        field: json["id_field"]??"",
      );

}
