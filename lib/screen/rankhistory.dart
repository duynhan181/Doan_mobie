import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_mobie/model/fieldmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doan_mobie/model/roundPlayModel.dart';
class RankHistoryPage extends StatefulWidget {
  Field chooseField1;
  RankHistoryPage({
    Key? key,
    required this.chooseField1,
  }) : super(key: key);
  @override
  _RankChoosePage createState() => _RankChoosePage(chooseField1: chooseField1);
}

class _RankChoosePage extends State<RankHistoryPage> {
  //hide/show password
  Field chooseField1;
  _RankChoosePage({
    required this.chooseField1,
  });

  List<RoundPlay> lstRoundPlay = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  String customDatetime(DateTime x) {
    String convertedDateTime =
        "${x.hour.toString().padLeft(2, '0')}:${x.minute.toString().padLeft(2, '0')}:${x.second.toString().padLeft(2, '0')}  ${x.day.toString()}-${x.month.toString().padLeft(2, '0')}-${x.year.toString().padLeft(2, '0')} ";
    return convertedDateTime;
  }

  Widget field(String name, String point, DateTime date) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
            ),
            Text(
              point,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
            ),
            Text(
              customDatetime(date),
              style: const TextStyle(
                  color: Color.fromARGB(255, 137, 26, 26), fontSize: 18),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                   gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 248, 10, 216),
                    Color.fromARGB(255, 84, 50, 237)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ' Bảng Xếp Hạng ${chooseField1.name_field}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Người chơi ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 116, 24, 158),
                                fontSize: 18),
                          ),
                          Text(
                            'Ngày giờ ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 116, 24, 158),
                                fontSize: 18),
                          ),
                          Text(
                            'Điểm ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 116, 24, 158),
                                fontSize: 18),
                          )
                        ],
                      ),

                      //  _namePoint(name),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("roundplay")
                                .where("field",
                                    isEqualTo: this.chooseField1.name_field)
                                .orderBy("point", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data!.docs;
                                lstRoundPlay = [];
                                for (var row in data) {
                                  final r = row.data() as Map<String, dynamic>;
                                  // ignore: unused_local_variable
                                  RoundPlay data = RoundPlay.fromJson(r);
                                  lstRoundPlay.add(data);
                                }
                                // ignore: avoid_print
                                // print("${lstField.length}");
                                return ListView.builder(
                                    //  scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    //  physics: const ScrollPhysics(),
                                    itemCount: lstRoundPlay.length,
                                    itemBuilder: (context, index1) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.people,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          '${lstRoundPlay[index1].name.toString()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          customDatetime(lstRoundPlay[index1]
                                              .date
                                              .toDate()),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        trailing: Text(
                                          '${lstRoundPlay[index1].point.toString()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(e.toString()),
                                );
                              }
                              return const Text('Loading..');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
