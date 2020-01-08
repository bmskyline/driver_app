class User {
  int id;
  String name;
  String email;
  String phone;
  String website;

  User(this.id, this.name, this.email, this.phone, this.website);

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        phone = json["phone"],
        website = json["website"];
}