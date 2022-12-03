import 'package:flutter/material.dart';
import 'package:skit_active/animation/FadeAnimation.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 120,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  /*FadeAnimation(1, */Text("Зарегистрироваться", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),/*)*/),
                  SizedBox(height: 20,),
                  /*FadeAnimation(1.2, */Text("Создать новый аккаунт", style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38
                  ),/*)*/),
                ],
              ),
              Column(
                children: <Widget>[
                  /*FadeAnimation(1.2, */makeInput(label: "Имя", icon: Icon(Icons.person, color: Colors.white70,)/*)*/),
                  /*FadeAnimation(1.3, */makeInput(label: "Почта", icon: Icon(Icons.mail, color: Colors.white70,)/*)*/),
                  /*FadeAnimation(1.4, */makeInput(label: "Пароль", obscureText: true, icon: Icon(Icons.lock, color: Colors.white70,)/*)*/),
                ],
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
                    onPressed: () {},
                    color: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("Зарегистрироваться", style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),),
                  ),
                ),
              )/*)*/,
            ],
          ),
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
            suffixIcon:
            Padding(
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