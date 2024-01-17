class AdData{
  String? id;
  String? title;
  String? image;
  DateTime? createdAt;


  AdData();
  AdData.fromJson(Map<String,dynamic> jsonData, String docId){
    id=docId;
    title=jsonData["title"];
    image=jsonData["image"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
                 jsonData['createdAt'].millisecondsSinceEpoch);

  }

  Map<String,dynamic> toJson(){
     Map<String,dynamic> adsData={};
     adsData["title"]=title;
     adsData["image"]=image;
     return adsData;

  }
}