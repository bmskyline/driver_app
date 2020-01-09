class User {
  int id;
  int userId;
  String title;

  User(this.id, this.userId, this.title);

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    userId = json["userId"],
    title = json["title"];

}