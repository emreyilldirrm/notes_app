import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_app/details_page.dart';
import 'package:notes_app/insert_data_page.dart';
import 'package:notes_app/test_score.dart';
import 'package:notes_app/test_score_D_A_O.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  home_page(),
    );
  }
}

class home_page extends StatefulWidget {

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  Future<List<test_score>>Show_all_data() async {

    var lessons = test_score_D_A_O().get_all_data();
    return lessons;


  }
Future<bool>App_Exit() async {
    await exit(0);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
          App_Exit();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Text("Anasayfa"),
          FutureBuilder<List<test_score>>(
            future: Show_all_data(),
            builder: (context, snapshot) {
            if(snapshot.hasData){
              var lesson_list = snapshot.data;

              double ortalama =0.0;
              if(!lesson_list!.isEmpty){
                double toplam=0.0;
                for(var l in lesson_list!){
                    toplam =toplam + (l.not1+l.not2)/2;
                }
                ortalama = toplam/lesson_list.length;

              }
              return Text("Ortalama : $ortalama",style: TextStyle(fontSize: 14,color: Colors.white),);
            }else{
              return Text("Ortalama : 0",style: TextStyle(fontSize: 14,color: Colors.white),);
            }
          },)
          ]),
      ),
      body: WillPopScope(
        onWillPop: App_Exit,
        child: FutureBuilder(
          future: Show_all_data(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var lessons_list = snapshot.data;

              return ListView.builder(
                  itemCount: lessons_list!.length,
                  itemBuilder: (context, index) {
                    var lesson=lessons_list[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => details_page(not: lesson),));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(lesson.ders_adi,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(lesson.not1.toString()),
                                Text(lesson.not2.toString())
                              ]),
                        ),
                      ),
                    );
                  },);

            }else{
              return Center();
            }
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => insert_data_page(),));
        },
        backgroundColor: Colors.orange,
        tooltip: 'insert_Button',
        child: const Icon(Icons.add),
      ),
    );
  }
}
