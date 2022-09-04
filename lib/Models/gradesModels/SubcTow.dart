class SubcTow{
  String id,name,className;
  int status,t;
  static String ocn="subc_tow";
  List grade_childs=[];
  SubcTow({this.id, this.name,this.className, this.status, this.t});
  SubcTow.fromjson(json){
    this.id=json['id'];
    this.name=json['name'];
    this.className=json['className'];
    this.status=json['status'];
    this.t=json['t'];
  }

  bool hasChild(){
    if(this.grade_childs.length>0){
      return true;
    }
    return false;
  }

}