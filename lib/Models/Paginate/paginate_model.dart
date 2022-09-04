class Pagination{
  String next;
  int current;
  var data;
  Pagination({this.next, this.data});
  Pagination.fromjson(json){
    current=json['current_page'];
    next=json['next_page_url'];
    data=json['data'];
  }
   Map toMap(){
    return {
      "current_page":current,
      "next_page_url":next,
      "data":data
    };
   }
}