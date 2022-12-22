import 'package:doan_mobie/screen/field_page.dart';
import 'package:doan_mobie/screen/history.dart';
import 'package:doan_mobie/screen/rankchoose.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: const BoxDecoration(
          gradient: LinearGradient(colors:[
                Color.fromARGB(255, 248, 10, 216),Color.fromARGB(255, 84, 50, 237)
            ],begin: Alignment.topCenter, end: Alignment.bottomCenter
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                  //image
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 150,
                      width: 150,
                      ),
                  ),
                 
                  const SizedBox(height: 60,),

                //Star
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context)=> FieldPage(),)
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                           child: Text(
                            'Bắt đầu',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                   SizedBox(height: 20,),

                  //bang xep hang
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: (){
                          Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context)=> RankChoosePage(),)
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                           child: Text(
                            'Bảng Xếp Hạng',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                   SizedBox(height: 20,),

                  //Lich su dau
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: (){
                          Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context)=> HistoryPage(),)
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                           child: Text(
                            'Lịch sử đấu',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                   SizedBox(height: 20,),

                  //Exit
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: (){
                        FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                           child: Text(
                            'Thoát',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
      



      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('Signed in as '+ user.email!),
      //       MaterialButton(onPressed: (){
      //         FirebaseAuth.instance.signOut();
      //       },
      //       color: Colors.deepPurple,
      //       child: Text('sign out'),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}