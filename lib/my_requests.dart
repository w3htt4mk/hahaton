import 'package:flutter/material.dart';

import 'custombotnav.dart';
import 'enums.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        title: Text('Мои заявки', style: TextStyle(color: Colors.white),),
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.my_requests,),
    );;
  }
}
