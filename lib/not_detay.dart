import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/category.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  String title;
  NoteDetail({this.title});
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  int categoryID=1;
  DatabaseHelper dbhelper;
  var formkey=GlobalKey<FormState>();
  List<Category> allcategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allcategories=List<Category>();
    dbhelper=DatabaseHelper();
    dbhelper.getCategories().then((mapList){
      for(Map maps in mapList){
        setState(() {
          allcategories.add(Category.fromMap(maps));
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          allcategories.length<=0 ? CircularProgressIndicator() :
          Center(
            child: Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(items: createCategoryItems(),value: categoryID, onChanged: (chosenCategory){
                  setState(() {
                    categoryID=chosenCategory;
                  });
                }),
              ),
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          )
        ],
      ),),
    );
  }

  List<DropdownMenuItem<int>> createCategoryItems() {
    List<DropdownMenuItem<int>> items=[];
    items= allcategories.map((category)=>DropdownMenuItem<int>(value: category.categoryID,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(category.categoryTitle,
        style: TextStyle(fontSize: 20,color:Colors.green.shade700),),
      ),)).toList();
    return items;
  }
}
