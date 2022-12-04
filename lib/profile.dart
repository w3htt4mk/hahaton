import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skit_active/custombotnav.dart';
import 'package:skit_active/enums.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skit_active/help.dart';
import 'package:skit_active/main.dart';

class ProfileScreen extends StatefulWidget {
  final String? sessionToken;

  const ProfileScreen({Key? key, this.sessionToken}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logout() async {
    var headers = {
      'Content-Type': 'application/json',
      'Session-Token': '${widget.sessionToken}',
    };

    var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/killSession');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    if (kDebugMode) {
      print(res.body);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  getname(String? sessionToken) async {
    var headers = {
      'Session-Token': '${sessionToken}',
    };

    var url =
        Uri.parse('https://hakahelp.admhmao.ru/apirest.php/getActiveProfile/');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    } // toString of Response's body is assigned to jsonDataString
    var data = jsonDecode(res.body)["active_profile"]["name"];
    if (kDebugMode) {
      print(data);
    }
  }

  @override
  void initState() {
    getname(widget.sessionToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: AppBar(
        title: const Text(
          "Профиль",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D1D1D),
        elevation: 0,
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
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
        sessionToken: widget.sessionToken,
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height - 175,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Пользователь",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(height: 10),
            const Text("username@skit-active.com",
                style: TextStyle(color: Colors.white70, fontSize: 15)),
            const SizedBox(height: 40),
            ProfileMenu(
              text: "Мой аккаунт",
              icon: const Icon(
                Icons.person,
                color: Colors.white70,
              ),
              press: () => {},
            ),
            ProfileMenu(
              text: "Справка",
              icon: const Icon(
                Icons.help,
                color: Colors.white70,
              ),
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpScreen()));
              },
            ),
            ProfileMenu(
              text: "Выйти",
              icon: const Icon(
                Icons.logout,
                color: Colors.white70,
              ),
              press: () {
                logout();
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFF262626),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
