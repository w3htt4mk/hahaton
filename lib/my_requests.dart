import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skit_active/custombotnav.dart';
import 'package:skit_active/enums.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyResults extends StatefulWidget {
  final String? sessionToken;

  const MyResults({Key? key, this.sessionToken}) : super(key: key);

  @override
  _MyResultsState createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  Future getAllTodos() async {
    try {
      var response = await http.get(
          Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/'),
          headers: {'Session-Token': '${widget.sessionToken}'});
      return json.decode(response.body);
    } catch (error) {
      rethrow;
    }
  }

  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        backgroundColor: const Color(0xFF1D1D1D),
        title: const Text("История"),
        centerTitle: true,
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
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white70,
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                  color: const Color(0xFF262626),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Text("${snapshot.data[index]['id']}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 40)),
                    title: Text(
                      snapshot.data[index]['name'],
                      style: const TextStyle(color: Colors.white70),
                    ),
                    subtitle: snapshot.data[index]['status'] == 1
                        ? const Text("Статус заявки: Создана",
                            style: TextStyle(color: Colors.white70))
                        : snapshot.data[index]['status'] == 2
                            ? const Text("Статус заявки: В работе (назначена)",
                                style: TextStyle(color: Colors.white70))
                            : snapshot.data[index]['status'] == 3
                                ? const Text(
                                    "Статус заявки: В работе (запланирована)",
                                    style: TextStyle(color: Colors.white70))
                                : snapshot.data[index]['status'] == 4
                                    ? const Text("Статус заявки: Ожидающие",
                                        style: TextStyle(color: Colors.white70))
                                    : snapshot.data[index]['status'] == 5
                                        ? const Text("Статус заявки: Решена",
                                            style: TextStyle(
                                                color: Colors.white70))
                                        : const Text("Статус заявки: Закрыто",
                                            style: TextStyle(
                                                color: Colors.white70)),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return Container(
                                  color: const Color(0xC51D1D1D),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text("Рейтинг",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RatingBar.builder(
                                          minRating: 1,
                                          itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.yellow[800],
                                              ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              this.rating = rating.toInt();
                                            });
                                          }),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.stars,
                          color: Colors.white70,
                        )),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                indent: 20,
                endIndent: 20,
              );
            },
          );
        },
        future: getAllTodos(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.my_requests,
        sessionToken: widget.sessionToken,
      ),
    );
  }
}
