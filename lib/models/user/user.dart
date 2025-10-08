class User {
  final int id;
  final String email;
  final String name;
  final int age;
  final String gender;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'age': age, 'gender': gender, 'address': address};
  }
}
