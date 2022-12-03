import 'package:flutter/material.dart';
import 'package:skit_active/custombotnav.dart';
import 'package:skit_active/enums.dart';
import 'package:skit_active/help.dart';

import 'package:glpi_dart/glpi_dart.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.sessionToken});

  final String? sessionToken;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late String _profilename;

  @override
  void initState() {
    super.initState();
    _getname();
  }

  _getname() async{
    String sessionToken = widget.sessionToken!;
    String sessionUser;
    GlpiClient client = GlpiClient("https://hakahelp.admhmao.ru/apirest.php");
    GlpiClient client2 = GlpiClient("https://hakahelp.admhmao.ru/apirest.php/get-active-profile");
    await client.initSessionUserToken("7RAPzlZMsU2UIgsrUw49wXlPiGdYcEUMyoTbnPOT");
    try {
      final response = await client.getActiveProfile();
      sessionUser = response['name'];

      _profilename = sessionUser;


    } on GlpiException catch (e) {
      // In case of will get the http status code (e.code) and the message (e.reason['error'])
      print('${e.code} - ${e.error} - ${e.message}');
    }

    print(_profilename);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1D1D),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile,),
      body: SingleChildScrollView(
        child: Container(

          height: MediaQuery.of(context).size.height - 175,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Пользователь", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
              SizedBox(height: 10),
              Text("w3htt4m.k@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 15)),
              SizedBox(height: 40),
              ProfileMenu(
                text: "Мой аккаунт",
                icon: Icon(Icons.person, color: Colors.white70,),
                press: () => {},
              ),
              ProfileMenu(
                text: "Настройки",
                icon: Icon(Icons.settings, color: Colors.white70,),
                press: () {},
              ),
              ProfileMenu(
                text: "Справка",
                icon: Icon(Icons.help, color: Colors.white70,),
                press: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));},
              ),
              ProfileMenu(
                text: "Выйти",
                icon: Icon(Icons.logout, color: Colors.white70,),
                press: () {},
              ),
            ],
          ),
        )
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFF262626),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}