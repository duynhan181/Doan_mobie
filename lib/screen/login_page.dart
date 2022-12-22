import 'package:doan_mobie/screen/forgotpassword_page.dart';
import 'package:doan_mobie/screen/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';



class LoginPage extends StatefulWidget {
  final VoidCallback ShowRegisterPage;
  const LoginPage({Key? key, required this.ShowRegisterPage}):super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    //loading circle
    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      });


    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
    );

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child:SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                 
                  const SizedBox(height: 40,),

                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  //password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.7),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  //signIn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 84, 84),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                           child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),

                     //Route reset password and register
            
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                         onTap: widget.ShowRegisterPage,
                          child: const Text(
                            'Đăng Ký',
                            style: TextStyle(
                              color: Color.fromARGB(255, 230, 86, 86),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
            
                          //Register
                           TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>const ForgotPasswordPage()));
                          },
                          child: const Text(
                            'Quên Mật Khẩu',
                            style: TextStyle(
                               color: Color.fromARGB(255, 230, 86, 86),
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      ],
                    ),
                  )          
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}