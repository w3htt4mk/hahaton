import 'package:flutter/material.dart';

import 'custombotnav.dart';
import 'enums.dart';

import 'package:http/http.dart' as http;

class MyRequests extends StatefulWidget {
  final String? sessionToken;
  const MyRequests(
      {Key? key, this.sessionToken})
      : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}


class _MyRequestsState extends State<MyRequests> {

  void getRequests() async {
    var headers = {
      'Content-Type': 'application/json',
      'Session-Token': '${widget.sessionToken}'
    };

    var params = {
      'expand_dropdowns': 'true',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/?expand_dropdowns=true&');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
    print(res.body.runtimeType);
  }


  @override
  void initState() {
    getRequests();
    super.initState();
  }


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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.my_requests, sessionToken: widget.sessionToken,),
    );;
  }
}
