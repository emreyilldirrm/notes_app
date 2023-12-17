import 'package:notes_app/VeritabaniYardimcisi.dart';
import 'package:notes_app/test_score.dart';

class test_score_D_A_O{

  Future<List<test_score>> get_all_data() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    return List.generate(maps.length, (i) {
        var satir = maps[i];
        return test_score(satir["not_id"], satir["ders_adi"], satir["not1"], satir["not2"]);
    });
  }


  Future<void>Insert_data(String ders_adi, int not1, int not2) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var data = Map<String,dynamic>();
    data["ders_adi"] = ders_adi;
    data["not1"] = not1; // "not1" olarak düzeltildi
    data["not2"] = not2;

     await db.insert("notlar", data);
  }

  Future<void>Delete_Data(int ders_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("notlar",where: "not_id=?",whereArgs: [ders_id]);

  }

  Future<void>Update_data(int ders_id,String ders_adi, int not1, int not2) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var data = Map<String,dynamic>();
    data["ders_adi"] = ders_adi;
    data["not1"] = not1; // "not1" olarak düzeltildi
    data["not2"] = not2;

    await db.update("notlar",data,where: "not_id=?",whereArgs: [ders_id]);

  }

}