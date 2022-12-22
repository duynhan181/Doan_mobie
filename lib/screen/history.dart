import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_mobie/model/roundPlayModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatefulWidget {
  @override
  _RankChoosePage createState() => _RankChoosePage();
}

class _RankChoosePage extends State<HistoryPage> {
  //hide/show password
  String? name = '';
  String uid = '';
  List<RoundPlay> lstRoundPlay = [];
  @override
  void initState() {
    super.initState();
    setState(() {});
    getUser();

    print('============${user.uid}');
  }

  final user = FirebaseAuth.instance.currentUser!;
  String customDatetime(DateTime x) {
    String convertedDateTime =
        "${x.hour.toString().padLeft(2, '0')}:${x.minute.toString().padLeft(2, '0')}:${x.second.toString().padLeft(2, '0')}  ${x.day.toString()}-${x.month.toString().padLeft(2, '0')}-${x.year.toString().padLeft(2, '0')} ";
    return convertedDateTime;
  }

  void getUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        
        setState(() {
          name = documentSnapshot["name"];
          print(name);
          uid = documentSnapshot["uid"];
          // print(uid);
        });
        //    print(uid);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Widget field(String name, String point, DateTime date, String a) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
            Text(
              a,
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
                    horizontal: 10.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                       //image
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            height: 100,
                            width: 100,
                          ),
                        ),

                         SizedBox(
                        height: 30,
                      ),
                        
                      const Text(
                        ' Lịch sử chơi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Lĩnh vực',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Người chơi',
                            style: TextStyle(
                               color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ngày giờ ',
                            style: TextStyle(
                               color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Điểm',
                            style: TextStyle(
                               color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      //  _namePoint(name),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Stack(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("roundplay")
                                .where("uid", isEqualTo: user.uid)
                                .orderBy("date", descending: true)
                                
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
                                    
                                    shrinkWrap: true,
                                    //  physics: const ScrollPhysics(),
                                    itemCount: lstRoundPlay.length,
                                    itemBuilder: (context, index1) {
                                      return ListTile(
                                        
                                        leading: Text(
                                          '${lstRoundPlay[index1].field}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
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
                                          style: TextStyle(
                                            fontSize: 17,),
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
                              return const CircularProgressIndicator();
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
