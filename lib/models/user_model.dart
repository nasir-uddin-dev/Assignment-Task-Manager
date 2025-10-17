class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String password;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
  });

  ///JSON -> OBJECT
  factory UserModel.fromJson(Map<String, dynamic> jsonData) => UserModel(
    email: jsonData['email'],
    firstName: jsonData['firstName'],
    lastName: jsonData['lastName'],
    mobile: jsonData['mobile'],
    password: jsonData['password'],
  );

  ///OBJECT -> JSON
  Map<String, dynamic> toJson() => {
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'mobile': mobile,
    'password': password,
  };
}
