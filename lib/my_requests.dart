import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skit_active/custombotnav.dart';
import 'package:skit_active/enums.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class MyResults extends StatefulWidget {

  final String? sessionToken;
  const MyResults(
      {Key? key, this.sessionToken})
      : super(key: key);

  @override
  _MyResultsState createState() => _MyResultsState();
}



class _MyResultsState extends State<MyResults> {

  Future getAllTodos() async {
    try {
      var response =
      await http.get(Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/'), headers: {'Session-Token': '${widget.sessionToken}'});
      return json.decode(response.body);
    } catch (error) {
      throw error;
    }
  }


  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Color(0xFF1D1D1D),
        title: Text("История"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          // WHILE THE CALL IS BEING MADE AKA LOADING
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.white70,));
          }

          // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // IF IT WORKS IT GOES HERE!
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF262626),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                child: ListTile(
                  leading: Text("${index+1}", style: TextStyle(color: Colors.white70, fontSize: 40)),
                  title: Text(snapshot.data[index]['name'], style: TextStyle(color: Colors.white70),),
                  subtitle: snapshot.data[index]['status'] == 1?
                    Text("Статус заявки: Создана", style: TextStyle(color: Colors.white70))
                    : snapshot.data[index]['status'] == 2?
                    Text("Статус заявки: В работе (назначена)", style: TextStyle(color: Colors.white70))
                    : snapshot.data[index]['status'] == 3?
                    Text("Статус заявки: В работе (запланирована)", style: TextStyle(color: Colors.white70))
                    : snapshot.data[index]['status'] == 4?
                    Text("Статус заявки: Ожидающие", style: TextStyle(color: Colors.white70))
                    : snapshot.data[index]['status'] == 5?
                    Text("Статус заявки: Решена", style: TextStyle(color: Colors.white70))
                    :Text("Статус заявки: Закрыто", style: TextStyle(color: Colors.white70)),
                  trailing: IconButton(onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                      return Container(
                        color: Color(0xC51D1D1D),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 40,),
                              Text("Рейтинг", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 35)),
                              SizedBox(height: 20,),
                              RatingBar.builder(
                                minRating: 1,
                                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.yellow[800],),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    this.rating = rating.toInt();
                                  });
                                }
                            ),
                              SizedBox(height: 40,),
                            ],
                          )
                      );
                      },
                    );
                  }, icon: Icon(Icons.stars, color: Colors.white70,)),
              ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                indent: 20,
                endIndent: 20,
              );
            },
          );
        },
        future: getAllTodos(),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.my_requests, sessionToken: widget.sessionToken,),
    );
  }

}