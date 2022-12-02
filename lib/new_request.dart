import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'custombotnav.dart';
import 'enums.dart';

const List<String> categorylist = <String>['Категория', '1кат', '2кат', '3кат', '4кат'];
const List<String> typelist = <String>['Тип', '1тип', '2тип', '3тип', '4тип'];

//подкрутить с апи

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {

  String dropdowncategoryValue = categorylist.first;
  String dropdowntypeValue = typelist.first;


  PlatformFile? pickedFile;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }



  Widget makeInput({label, obscureText = false, icon, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white70
        ),),
        SizedBox(height: 5,),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: Color(0xFF262626),
            filled: true,
            suffixIcon:
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: icon,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 22.5, horizontal: 15),
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
        SizedBox(height: 30,),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        title: Text('Новая заявка', style: TextStyle(color: Colors.white),),
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.new_request,),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 20,
          width: double.infinity,
          child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
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
                      items: categorylist.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 40,),
                    DropdownButton<String>(
                      value: dropdowntypeValue,
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
                          dropdowntypeValue = value!;
                        });
                      },
                      dropdownColor: Color(0xFF262626),
                      items: typelist.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                makeInput(label: "Телефон", icon: Icon(Icons.phone, color: Colors.white70,),),
                makeInput(label: "Заголовок", icon: Icon(Icons.title, color: Colors.white70,),),
                makeInput(label: "Описание", icon: Icon(Icons.text_fields, color: Colors.white70,),),
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
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("Выбрать файл", style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 23
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                        // Отправить заявку
                      },
                      color: Colors.orange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("Отправить", style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 23
                      ),),
                    ),
                  ),
                )
              ]
          ),
        ),
      )

    );


}
}
