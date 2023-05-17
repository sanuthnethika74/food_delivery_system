class User {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String city;
  final String address;
  final String password;
  final String confirmPassword;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.city,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      city: json['city'] ?? '',
      address: json['address'],
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobileNo': mobileNo,
        'city': city,
        'address': address,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
