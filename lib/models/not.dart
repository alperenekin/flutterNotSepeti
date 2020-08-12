class Not{
  int notID;
  int categoryID;
  String notTitle;
  String notContext;
  String notDate;
  int notPriorty;

  Not(this.categoryID, this.notTitle, this.notContext, this.notDate,
      this.notPriorty);

  Not.withID(this.notID, this.categoryID, this.notTitle, this.notContext, this.notDate,
      this.notPriorty);

  Map<String,dynamic> toMap(){
  var map=Map<String,dynamic>();
  map['notID']=this.notID;
  map['kategoriID']=this.categoryID;
  map['notBaslik']=this.notTitle;
  map['notIcerik']=this.notContext;
  map['notTarih']=this.notDate;
  map['notOncelik']=this.notPriorty;
  return map;
  }
  Not.fromMap(Map<String,dynamic> map){
    notID=map['notID'];
    categoryID=map['kategoriID'];
    notTitle=map['notBaslik'];
    notContext=map['notIcerik'];
    notDate=map['notTarih'];
    notPriorty=map['notOncelik'];
  }

  @override
  String toString() {
    return 'Not{notID: $notID, categoryID: $categoryID, notTitle: $notTitle, notContext: $notContext, notDate: $notDate, notPriorty: $notPriorty}';
  }
}