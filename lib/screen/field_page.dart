import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doan_mobie/model/fieldmodel.dart';
import 'package:intl/intl.dart';
import 'package:doan_mobie/screen/displaypage.dart';


class FieldPage extends StatefulWidget {
  @override
  _ChooseFieldState createState() => _ChooseFieldState();
}

class _ChooseFieldState extends State<FieldPage> {
  //hide/show password
  final user = FirebaseAuth.instance.currentUser!;
  List<Field> lstField = [];
  late int index;

  String name = '';
  String uid = '';
  @override
  void initState() {
    super.initState();

  }
  void showSnackBar(String x) {
    final snackBar = SnackBar(content: Text(x));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget field(String x, Field y) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      width: double.infinity,
      // decoration:BoxDecoration(
      //   color: Colors.white.withOpacity(0.7),
      //   borderRadius: BorderRadius.circular(12),
      // ), 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.7),
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(12)
          ),
        ),
       onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPage(
              ChooseField1: y,
            ),
          ),
        );
       },
        child: Text(
          x,
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ),
      ),
    );
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

                       //image
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            height: 150,
                            width: 150,
                          ),
                        ),

                       const SizedBox(height: 30.0),

                      const Text(
                        ' Chọn lĩnh vực',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                     
                      const SizedBox(
                        height: 30.0,
                      ),
                      Stack(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("fields")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data!.docs;
                                lstField = [];
                                for (var row in data) {
                                  final r = row.data() as Map<String, dynamic>;
                                  // ignore: unused_local_variable
                                  Field data = Field.fromJson(r);
                                  lstField.add(data);
                                }
                                // ignore: avoid_print
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: lstField.length,
                                    itemBuilder: (context, index1) {
                                      return Column(
                                        children: <Widget>[
                                          field(
                                            lstField[index1]
                                                .name_field
                                                .toString(),
                                            lstField[index1],
                                          ),
                                          const SizedBox(height: 20.0,),
                                        ],
                                      );
                                      
                                    });
                                    
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(e.toString()),
                                );
                              }
                              return const Text('Loang......');
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
