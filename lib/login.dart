import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skit_active/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login(String key) async {
    var headers = {
      'Authorization': 'Basic $key',
    };

    var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/initSession/');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    String jsonsDataString = res.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var data = jsonDecode(jsonsDataString);
    if (kDebugMode) {
      print(data["session_token"]);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  sessionToken: data["session_token"],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF1D1D1D),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF1D1D1D),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height + 100,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: const <Widget>[
                          Text(
                            "Войти",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Войти в свой аккаунт",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white38),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            makeInput(
                                label: "Логин",
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                ),
                                controller: _emailController),
                            makeInput(
                                label: "Пароль",
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.white70,
                                ),
                                obscureText: true,
                                controller: _passwordController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 70,
                            onPressed: () {
                              final str =
                                  "${_emailController.text}:${_passwordController.text}";
                              final bytes = utf8.encode(str);
                              final base64Str = base64.encode(bytes);
                              login(base64Str);
                            },
                            color: Colors.orange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              "Войти",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget makeInput({label, obscureText = false, icon, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          style: const TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: const Color(0xFF262626),
            filled: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: icon,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22.5, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
