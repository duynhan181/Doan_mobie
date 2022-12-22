import 'package:doan_mobie/model/fieldmodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:doan_mobie/model/questionmodel.dart';
// ignore: must_be_immutable
class ChooseQuestion extends StatefulWidget {
  List<Question> lstQuestion;
  Field ChooseField;
  // int chon;
  ChooseQuestion({
    Key? key,
    required this.lstQuestion,
    // ignore: non_constant_identifier_names
    required this.ChooseField,
    // required this.chon
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ChooseQuestion> createState() =>
      // ignore: no_logic_in_create_state
      _ChooseQuestionState(lstQuestion: lstQuestion, ChooseField: ChooseField);
}

class _ChooseQuestionState extends State<ChooseQuestion> {
  _ChooseQuestionState({
    required this.lstQuestion,
    // ignore: non_constant_identifier_names
    required this.ChooseField,
  });
  List<Question> lstQuestion;
  // ignore: non_constant_identifier_names
  Field ChooseField;
  String answer = '';
  int round = 0;
  int second = 20;
  bool stop = false;
  int numQuestion = 0;
  Question question = Question(
    idQuestion: '',
    content: '',
    answer: '',
    a: '',
    b: '',
    c: '',
    d: '',
    field: '',
  );
  String name = '';
  String uid = '';
  int point = 0;


  final user = FirebaseAuth.instance.currentUser!;
  void onLoading() {
    setState(() {
      question = lstQuestion[0];
      numQuestion = lstQuestion.length;
    });
  }

  void countdown() {
    setState(() {
      if (second > 0) {
        if (!stop) {
          second -= 1;
          Future.delayed(Duration(seconds: 1), countdown);
        }
      } else {
        notification("Bạn đã hết thời gian", "Ok để thoát", false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    onLoading();
    countdown();
    setState(() {
      getUser();
      _namePoint(name);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  Widget _namePoint(String x) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tên: $x',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '${round + 1}/$numQuestion',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    );
  }

  CollectionReference roundplay =
      FirebaseFirestore.instance.collection('roundplay');

  Future<void> addRoundPlay(String a, String x, String y, int z) {
    return roundplay
        .doc()
        .set({
          'field': a,
          'uid': x,
          'name': y,
          'point': z,
          'date': DateTime.now(),
        })
        .then((value) => print("ADDED"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget _questionText(String x) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          backgroundColor: Color.fromARGB(255, 199, 200, 185),
          shape: const StadiumBorder(),
        ),
        child: Text(
          x,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  Widget _answer(String x, String key) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            answer = x;
          });

          if (question.answer == x && answer == x) {
            if (round < numQuestion - 1) {
              notification("Câu trả lời của bạn đúng", "Ok, để tiếp tục", true);
            } else {
              point += 10;
              notification("Bạn đã chiến thắng!", "Ok, để tiếp tục", false);
              
            }
          } else {
            notification(
                "Câu trả lời của bạn sai", "Mời bạn thoát!", false);
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 15,
          shadowColor: Colors.black,
          backgroundColor: question.answer == x && answer == x
              ? Colors.green
              : answer == x
                  ? Color.fromARGB(255, 149, 140, 128)
                          : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          shape: const StadiumBorder(),
        ),
        child: Text(
          x,
          style: TextStyle(color: Color(0xFF6CA8F1), fontSize: 18),
        ),
      ),
    );
  }

  Widget _time() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: Text(
          '$second',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future notification(String title, String content, bool check) {
    stop = true;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text(title),
        content: Text(content),
        actions: [
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              child: const Text("Ok"),
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
                stop = false;
                if (check) {
                  point += 10;
                  if (round < numQuestion - 1) {
                    answer = '';
                    round += 1;
                    second = 20;
                    question = lstQuestion[round];
                    countdown();
                    print(point);
                  }
                } else {
                  addRoundPlay(this.widget.ChooseField.name_field, user.uid,
                      user.displayName ?? name, point);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(String x) {
    final snackBar = SnackBar(content: Text(x));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        // print(this.widget.ChooseField.name_field);
        setState(() {
          name = documentSnapshot["name"];
          print(name);
          uid = documentSnapshot["uid"];
        });
        //    print(uid);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20,),

               _time(),


              const SizedBox(
                height: 25.0,
              ),
             
              _questionText(question.content),
              _answer(question.a, 'a'),
              _answer(question.b, 'b'),
              _answer(question.c, 'c'),
              _answer(question.d, 'd'),
              const SizedBox(
                height: 10.0,
              ),
             
            ],
          ),
        ),
      ],
    );
  }
}
