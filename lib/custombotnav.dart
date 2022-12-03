import 'package:flutter/material.dart';
import 'package:skit_active/my_requests.dart';
import 'package:skit_active/new_request.dart';
import 'package:skit_active/profile.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
    this.sessionToken,
  }) : super(key: key);

  final MenuState selectedMenu;
  final String? sessionToken;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.white70;
    final Color PrimaryColor = Colors.orange;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.history, color: MenuState.my_requests == selectedMenu
                  ? PrimaryColor
                  : inActiveIconColor,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyResults(sessionToken: sessionToken,))),
              ),
              IconButton(
                icon: Icon(Icons.add, color: MenuState.new_request == selectedMenu
                    ? PrimaryColor
                    : inActiveIconColor,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewRequest(sessionToken: sessionToken,))),
              ),
              IconButton(
                icon: Icon(Icons.person, color: MenuState.profile == selectedMenu
                    ? PrimaryColor
                    : inActiveIconColor,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(sessionToken: sessionToken,))),
              ),
            ],
          )),
    );
  }
}