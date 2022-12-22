import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_mobie/model/questionmodel.dart';
import 'package:flutter/material.dart';
import 'package:doan_mobie/model/fieldmodel.dart';
import 'package:doan_mobie/screen/questions_page.dart';

class DisplayPage extends StatefulWidget {
  Field ChooseField1;
  DisplayPage({
    Key? key,
    required this.ChooseField1,
  }) : super(key: key);

  @override

  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DisplayPageState createState() =>
      _DisplayPageState(ChooseField1: ChooseField1);
}

class _DisplayPageState extends State<DisplayPage> {
  _DisplayPageState({required this.ChooseField1});
  Field ChooseField1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // String Now =
  //     '${DateTime.now().day < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}${DateTime.now().month}${DateTime.now().year}';

  // var lst;
  // Future getListQuestion() async {
  //   await FirebaseFirestore.instance
  //       .collection("listquestion")
  //       .doc('08122022')
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       lst = snapshot.data()!["list_Question"];
  //       print('thanh cong');
  //     } else
  //       print('that bai');
  //   });
  // }

  int index = 0;
  List<Question> lstQuestion = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 248, 10, 216),
                  Color.fromARGB(255, 84, 50, 237)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
               gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 248, 10, 216),
                  Color.fromARGB(255, 84, 50, 237)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Question")
                  .where("id_field", isEqualTo: ChooseField1.id_field)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  for (var row in data) {
                    final r = row.data() as Map<String, dynamic>;
                    Question data = Question.fromJson(r);
                    lstQuestion.add(data);
                  }
                  return ChooseQuestion(
                      lstQuestion: lstQuestion, ChooseField: ChooseField1);
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Loading..'),
                  );
                }
                return const Center(
                  child: Text('Loading..'),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
