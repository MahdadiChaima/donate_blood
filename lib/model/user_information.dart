class UserInformation {
  final String username;
  final String uid;
  final String bloodType;
  final String phoneNumber;
  final String location;
  final String gender;
  final String? status;

  UserInformation({
    required this.username,
    required this.bloodType,
    required this.uid,
    required this.phoneNumber,
    required this.gender,
    required this.location,
    this.status,
  });

  Map<String, Object> toMap() {
    return {
      'fullName': username,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'bloodType': bloodType,
      'location': location,
      'gender': gender,
      'status': status??'',
    };
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      username: map['fullName'],
      bloodType: map['bloodType'],
      uid: map['uid'],
      phoneNumber: map['phoneNumber'],
      location: map['location'],
      gender: map['gender'],
      status: map['status'],
    );
  }
}