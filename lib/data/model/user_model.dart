class Shop {
  int id;
  int userId;
  String title;

  Shop(this.id, this.userId, this.title);

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json["userId"],
        title = json["title"];
}
