import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/test_score.dart';
import 'package:notes_app/test_score_D_A_O.dart';

class details_page extends StatefulWidget {
  test_score not;


  details_page({required this.not});

  @override
  State<details_page> createState() => _details_pageState();
}

class _details_pageState extends State<details_page> {

  var tfders_adi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();

  Future<void>delete_Data(int ders_id) async {
    await test_score_D_A_O().Delete_Data(ders_id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => home_page(),));
  }

  Future<void>update_Data(int ders_id ,String ders_adi,int not1,int not2) async {
    await test_score_D_A_O().Update_data(ders_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => home_page(),));
  }

  @override
  void initState() {
    super.initState();

    tfders_adi.text=widget.not.ders_adi;
    tfnot1.text=widget.not.not1.toString();
    tfnot2.text=widget.not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: [
          TextButton(onPressed: (){
            update_Data(widget.not.not_id, tfders_adi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
          }, child: Text("Güncelle")),
          TextButton(onPressed: (){
              delete_Data(widget.not.not_id);
          },  child: Text("Sil")),

        ],
        title: Text("Detay Sayfası"),
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
    );;
  }
}
