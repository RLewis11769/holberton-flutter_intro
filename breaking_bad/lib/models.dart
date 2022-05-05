class Character {
  String name = "";
  String imgUrl = "";
  int id = 0;

  Character(this.name, this.imgUrl, this.id);

  Character.fromJson(Map<String, dynamic> json) {
    Character(
      name = json['name'],
      imgUrl = json['img'],
      id = json['char_id'],
    );
  }
}
