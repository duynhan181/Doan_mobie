import 'package:doan_mobie/screen/login_page.dart';
import 'package:doan_mobie/screen/register_page.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(ShowRegisterPage: toggleScreens,);
    }else{
      return RegisterPage(showLoginPage: toggleScreens,);
    }
  }
}