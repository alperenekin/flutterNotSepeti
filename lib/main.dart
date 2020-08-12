import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/category.dart';
import 'package:flutter_not_sepeti/not_detay.dart';
import 'utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var databaseHelper=DatabaseHelper();
    databaseHelper.getCategories();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: NotListesi(),
    );
  }
}
class NotListesi extends StatelessWidget {
  DatabaseHelper dbhelper=DatabaseHelper();
  var _scaffoldkey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Center(child: Text("Not Sepeti"),),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(onPressed: (){
            addCategoryDialog(context);
          },mini: true,child: Icon(Icons.add_circle),
            heroTag: "kategori ekle",),
          FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteDetail(title: "Not Ekle",)));
          },child: Icon(Icons.add),
          heroTag: "Not ekle",)
        ],
      ),
      body: Container(),
    );
  }

  void addCategoryDialog(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    String kategoriadi;
    showDialog(context: context,builder: (context){
      return SimpleDialog(
        title: Text("Kategori Ekle",style: TextStyle(color: Theme.of(context).primaryColor),) ,
        children: <Widget>[
          Form(key:formKey,
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onSaved: (input){
                kategoriadi=input;
              },
              validator: (input){
                if(input.length<3){
                  return "En az 3 karakter giriniz";
                }
              },
              decoration: InputDecoration(
                labelText: "Kategori adı",
                border: OutlineInputBorder(),
              ),
            ),
          )),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.green,child: Text("Vazgeç",style: TextStyle(color: Colors.white),),),
              RaisedButton(onPressed: (){
                if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  dbhelper.addCategory(
                      Category(kategoriadi)).then((categoryId){
                      if(categoryId>0){
                        _scaffoldkey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor:Colors.green,
                              content: Text("Kategori eklendi."),
                              duration: Duration(seconds: 2),
                            ));
                        debugPrint(categoryId.toString() +"eklendi");
                        Navigator.pop(context);
                      }
                  });
                }
              },
                color: Colors.green,child: Text("Kaydet",style: TextStyle(color: Colors.white),),),
            ],
          )
        ],
      );
    });
  }
}
