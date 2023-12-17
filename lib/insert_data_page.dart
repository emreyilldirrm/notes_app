import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/test_score.dart';
import 'package:notes_app/test_score_D_A_O.dart';

class insert_data_page extends StatefulWidget {

  @override
  State<insert_data_page> createState() => _insert_data_pageState();
}

class _insert_data_pageState extends State<insert_data_page> {
  var tfders_adi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();

  Future<void>Save_Data(String ders_adi,int not1,int not2) async {
   await test_score_D_A_O().Insert_data(ders_adi, not1, not2);
   Navigator.push(context, MaterialPageRoute(builder: (context) => home_page(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Ders Ekleme Sayfası"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(

                controller: tfders_adi,
                decoration: InputDecoration(hintText: "Ders Adı"),

              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(hintText: "2. Not"),
              )

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Save_Data(tfders_adi.text,int.parse(tfnot1.text),int.parse(tfnot2.text));
      },backgroundColor: Colors.orange,
          label: Text("Kaydet"),
        tooltip: 'Save_Button',
        icon: const Icon(Icons.save),
      )


    );;
  }
}
