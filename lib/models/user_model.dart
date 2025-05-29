class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String address;
  final String mobile;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.address,
    required this.mobile,
    this.profileImage,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      fullName: map['fullName'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      mobile: map['mobile'] ?? '',
      profileImage: map['profileImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'address': address,
      'mobile': mobile,
      'profileImage': profileImage,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? userName,
    String? email,
    String? address,
    String? mobile,
    String? profileImage,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
