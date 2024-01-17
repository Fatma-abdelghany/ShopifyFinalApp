class NotificationData {
  String? id;
  String? title;
  DateTime? createdAt;
  String? userToken;

  NotificationData();
  NotificationData.fromJson(Map<String, dynamic> jsonData, [String? docId]) {
    id = docId;
    title = jsonData["title"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        jsonData['createdAt'].millisecondsSinceEpoch);
    ;
    userToken = jsonData["userToken"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['userToken'] = userToken;
    return data;
  }
}
