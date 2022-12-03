import 'dart:convert';

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

//подкрутить с апи

class NewRequest extends StatefulWidget {
  final String? sessionToken;

  const NewRequest({Key? key, this.sessionToken}) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  @override
  void initState() {
    print(widget.sessionToken);
    super.initState();
  }

  void makerequest(
      String title, String phone, String description, int urgency, String category) async {
    var headers = {
      'Content-Type': 'application/json',
      'Session-Token': '${widget.sessionToken}',
    };
    print(widget.sessionToken);

    var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/');
    var res = await http.post(url,
        headers: headers,
        body:
            '{"input" : {"name":"${title}", "phone":"${phone}", "content":"${description}", "urgency":${urgency}, "impact":10, "requesttypes_id": 1, "itilcategories_id": "Категория заявки вторая""}}');
    if (res.statusCode != 201)
      throw Exception(
          'http.post error: statusCode= ${res.statusCode} ${res.reasonPhrase}');
    print(res.body);

    //НЕ РАБОТАЕТ ПРИКРЕПЛЕНИЕ ФАЙЛОВ АААААААААААА

    /*var url = Uri.parse('https://hakahelp.admhmao.ru/apirest.php/ticket/');
    var req = new http.MultipartRequest('POST', url)
      ..fields['uploadManifest'] = '{"input": {"name": "Uploaded document", "phone":"123", "content":"content", "urgency":3, "impact":10, "requesttypes_id": 1, "_filename" : ["${pickedFile?.name}"]}};type=application/json'
      ..files.add(await http.MultipartFile.fromPath(
          'filename[0]', '${pickedFile?.path}'));
    req.headers['Content-Type'] = 'multipart/form-data';
    req.headers['Session-Token'] = '${widget.sessionToken}';
    var res = await req.send();
    if (res.statusCode != 201) throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.stream);*/
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
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: Color(0xFF262626),
            filled: true,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 10),
              child: icon,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 22.5, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1D1D1D)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF1D1D1D),
        appBar: AppBar(
          title: Text(
            'Новая заявка',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1D1D1D),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
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
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 20,
            width: double.infinity,
            child: Column(children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
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
                    dropdownColor: Color(0xFF262626),
                    items: categorylist
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    width: 40,
                  ),
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
                    dropdownColor: Color(0xFF262626),
                    items: urgencylist.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("${value}"),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              makeInput(
                  label: "Телефон",
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white70,
                  ),
                  controller: phone_controller),
              makeInput(
                  label: "Заголовок",
                  icon: Icon(
                    Icons.title,
                    color: Colors.white70,
                  ),
                  controller: title_controller),
              makeInput(
                  label: "Описание",
                  icon: Icon(
                    Icons.text_fields,
                    color: Colors.white70,
                  ),
                  controller: description_controller),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
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
                    child: Text(
                      "Выбрать файл",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 70,
                    onPressed: () {
                      makerequest(title_controller.text, phone_controller.text,
                          description_controller.text, dropdownurgencyValue, dropdowncategoryValue);
                      // Отправить заявку
                    },
                    color: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
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
