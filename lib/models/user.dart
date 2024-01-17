class UserModel {
  String? id;
  String? name;
  String? phone;
  String? Adddress;
  String? mail;
  String? image;
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    name = json['name'];
    phone = json['phone'];
    Adddress = json['Adddress'];
    mail = json['mail'];
    image = json['image'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {};
  //   data['name'] = name;
  //   data['mail'] = mail;
  //   data['Adddress'] = Adddress;
  //   data['phone'] = phone;
  //   return data;
  // }

  Map<String, dynamic> toJson() => {
        "name": name,
        "mail": mail,
        "Adddress": Adddress,
        "phone": phone,
        "image":image,
      };
}
