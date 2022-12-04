import 'package:flutter/material.dart';
import 'package:skit_active/login.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: const <Widget>[
                  Text(
                    "Добро пожаловать!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Мобильная версия для ПАК Скит-Актив. Приложение для подачи заявки инициатором и отслеживания работы по ней.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset(
                  'assets/illustration2.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 70,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        color: Colors.orange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "Вход",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontSize: 23),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
