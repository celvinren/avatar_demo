class People {
  String id;
  String image;
  int age;
  String gender;
  bool isFriend;
  List<int> interests;

  People(
      {this.id,
      this.image,
      this.age,
      this.gender,
      this.isFriend,
      this.interests});

  People.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    isFriend = json['is_friend'];
    interests = json['interests'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['is_friend'] = this.isFriend;
    data['interests'] = this.interests;
    return data;
  }
}
