import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'custombotnav.dart';
import 'enums.dart';

import 'package:http/http.dart' as http;

const List<String> categorylist = <String>[
  'Категория заявки',
  'Категория заявки вторая',
  'Категория заявки третья',
  'Категория заявки четвертая',
  'Категория заявки пятая'
];

const List<int> urgencylist = <int>[1, 2, 3, 4];


class NewRequest extends StatefulWidget {
  final String? sessionToken;

  const NewRequest({Key? key, this.sessionToken}) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.sessionToken);
    }
    super.initState();
  }

  void makerequest(String title, String phone, String description, int urgency,
      int catid) async {
    var headers = {
      'Content-Type': 'application/json',
      'Session-Token': '${widget.sessionToken}',
    };
    if (kDebugMode) {
      print(widget.sessionToken);
    }

    var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/');
    var res = await http.post(url,
        headers: headers,
        body:
            '{"input" : {"name":"$title", "phone":"$phone", "content":"$description", "urgency":$urgency, "impact":10, "requesttypes_id": 1, "itilcategories_id": $catid}}');
    if (res.statusCode != 201) {
      throw Exception(
          'http.post error: statusCode= ${res.statusCode} ${res.reasonPhrase}');
    }
    if (kDebugMode) {
      print(res.body);
    }
  }

  String dropdowncategoryValue = categorylist.first;
  int dropdownurgencyValue = urgencylist.first;

  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  final phone_controller = TextEditingController();
  final title_controller = TextEditingController();
  final description_controller = TextEditingController();

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
          keyboardType: TextInputType.multiline,
          maxLines: null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF1D1D1D),
        appBar: AppBar(
          title: const Text(
            'Новая заявка',
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
            selectedMenu: MenuState.new_request,
            sessionToken: widget.sessionToken),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height - 20,
            width: double.infinity,
            child: Column(children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Категория заявки",
                        style: TextStyle(color: Colors.white),
                      ),
                      DropdownButton<String>(
                        value: dropdowncategoryValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white70),
                        underline: Container(
                          height: 2,
                          color: Colors.white70,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdowncategoryValue = value!;
                          });
                        },
                        dropdownColor: const Color(0xFF262626),
                        items: categorylist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Важность заявки",
                          style: TextStyle(color: Colors.white)),
                      DropdownButton<int>(
                        value: dropdownurgencyValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white70),
                        underline: Container(
                          height: 2,
                          color: Colors.white70,
                        ),
                        onChanged: (int? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownurgencyValue = value!;
                          });
                        },
                        dropdownColor: const Color(0xFF262626),
                        items:
                            urgencylist.map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text("$value"),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              makeInput(
                  label: "Телефон",
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white70,
                  ),
                  controller: phone_controller),
              makeInput(
                  label: "Заголовок",
                  icon: const Icon(
                    Icons.title,
                    color: Colors.white70,
                  ),
                  controller: title_controller),
              makeInput(
                  label: "Описание",
                  icon: const Icon(
                    Icons.text_fields,
                    color: Colors.white70,
                  ),
                  controller: description_controller),
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
                      selectFile();
                    },
                    color: Colors.white38,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "Выбрать файл",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                      switch (dropdowncategoryValue) {
                        case "Категория заявки":
                          var catid = 213;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                          break;
                        case "Категория заявки вторая":
                          var catid = 214;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                          break;
                        case "Категория заявки третья":
                          var catid = 217;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                          break;
                        case "Категория заявки четвертая":
                          var catid = 216;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                          break;
                        case "Категория заявки пятая":
                          var catid = 215;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                          break;
                        default:
                          var catid = 213;
                          makerequest(
                              title_controller.text,
                              phone_controller.text,
                              description_controller.text,
                              dropdownurgencyValue,
                              catid);
                      }
                      // Отправить заявку
                    },
                    color: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "Отправить",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
