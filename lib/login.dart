import 'package:flutter/material.dart';
import 'package:skit_active/animation/FadeAnimation.dart';
import 'package:skit_active/profile.dart';
import 'package:http/http.dart' as http;

import 'package:glpi_dart/glpi_dart.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String baseUrl = "https://hakahelp.admhmao.ru/apirest.php";

  void _login() async{
    GlpiClient client = GlpiClient(baseUrl);
    String? sessionToken;

    // Get the session token
    try {
      final response =
      await client.initSessionUsernamePassword(_emailController.text, _passwordController.text);
      sessionToken = response['session_token'];


      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(sessionToken: sessionToken)));

    } on GlpiException catch (e) {
      // In case of will get the http status code (e.code) and the message (e.reason['error'])
      print('${e.code} - ${e.error} - ${e.message}');
    }

    print(sessionToken);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xFF1D1D1D),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      /*FadeAnimation(1, */Text("Войти", style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),/*),*/
                      SizedBox(height: 20,),
                      /*FadeAnimation(1.2, */Text("Войти в свой аккаунт", style: TextStyle(
                          fontSize: 20,
                          color: Colors.white38
                      ),/*)*/),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        /*FadeAnimation(1.2, */makeInput(label: "Почта", icon: Icon(Icons.mail, color: Colors.white70,), controller: _emailController/*)*/),
                        /*FadeAnimation(1.3, */makeInput(label: "Пароль", icon: Icon(Icons.lock, color: Colors.white70,), obscureText: true, controller: _passwordController),/*)*/
                      ],
                    ),
                  ),
                  /*FadeAnimation(1.4, */Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 70,
                        onPressed: () {
                          _login();
                        },
                        color: Colors.orange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text("Войти", style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 23
                        ),),
                      ),
                    ),
                  )/*),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, icon, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white70
        ),),
        SizedBox(height: 5,),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: Color(0xFF262626),
            filled: true,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 10),
              child: icon,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 22.5, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}