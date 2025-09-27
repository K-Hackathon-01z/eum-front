class UserSignupRequest {
  final String email;
  final String name;
  final int age;
  final String address;
  final String gender;

  UserSignupRequest({
    required this.email,
    required this.name,
    required this.age,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {'email': email, 'name': name, 'age': age, 'address': address, 'gender': gender};
}
