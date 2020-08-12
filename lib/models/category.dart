class Category{
  int categoryID;
  String categoryTitle;
  Category(this.categoryTitle);
  Category.withID(this.categoryID,this.categoryTitle);
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['kategoriID']=categoryID;
    map['kategoriBaslik']=categoryTitle;
    return map;
  }
  Category.fromMap(Map<String,dynamic> map){
    this.categoryID=map['kategoriID'];
    this.categoryTitle=map['kategoriBaslik'];
  }

  @override
  String toString() {
    return 'Category{categoryID: $categoryID, categoryTitle: $categoryTitle}';
  }
}