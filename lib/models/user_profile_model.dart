class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobileNo;
  final int userType;
  final String profilePic;
  final String? sellerId;
  final UserDetail userDetail;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobileNo,
    required this.userType,
    required this.profilePic,
    this.sellerId,
    required this.userDetail,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      userType: json['userType'] ?? 0,
      profilePic: json['profilePic'] ?? '',
      sellerId: json['sellerId'],
      userDetail: UserDetail.fromJson(json['userDetail'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'mobileNo': mobileNo,
        'userType': userType,
        'profilePic': profilePic,
        'sellerId': sellerId,
        'userDetail': userDetail.toJson(),
      };
}

class UserDetail {
  final String id;
  final String country;
  final String city;
  final String address;
  final int v;
  final String deliveryAddress;
  final String deliveryCity;

  UserDetail({
    required this.id,
    required this.country,
    required this.city,
    required this.address,
    required this.v,
    required this.deliveryAddress,
    required this.deliveryCity,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['_id'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      v: json['__v'] ?? 0,
      deliveryAddress: json['deliveryAddress'] ?? '',
      deliveryCity: json['deliveryCity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'country': country,
        'city': city,
        'address': address,
        '__v': v,
        'deliveryAddress': deliveryAddress,
        'deliveryCity': deliveryCity,
      };
}
