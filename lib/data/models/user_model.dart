import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';
import 'package:untitled19/core/enum/role_enum.dart';

part 'user_model.g.dart';

@HiveType(typeId: 9)
class UserModel {
  @HiveField(0)
  final RoleEnum role;
  @HiveField(1)
  final String uid;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final bool isOnline;
  @HiveField(6)
  final Timestamp lastSeen;
  @HiveField(7)
  final Timestamp createdAt;
  @HiveField(8)
  final String? fcmToken;
  @HiveField(9)
  final List<String> blockedUsers;

  // Profile info
  @HiveField(10)
  final int? age;
  @HiveField(11)
  final String? disease;
  @HiveField(12)
  final BloodTypeEnum? bloodType;
  @HiveField(13)
  final GenderEnum? gender;
  @HiveField(14)
  final int? weight;
  @HiveField(15)
  final String? imagePath;
  @HiveField(16)
  final int? height;
  @HiveField(17)
  final String? location;
  @HiveField(18)
  final String? specialization;

  UserModel({
    this.specialization,
    required this.role,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isOnline = false,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    this.fcmToken,
    this.blockedUsers = const [],
    this.age,
    this.disease,
    this.bloodType,
    this.gender,
    this.weight,
    this.imagePath,
    this.height,
    this.location,
  })  : lastSeen = lastSeen ?? Timestamp.now(),
        createdAt = createdAt ?? Timestamp.now();

  UserModel copyWith({
    String? specialization,
    RoleEnum? role,
    String? uid,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? isOnline,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    String? fcmToken,
    List<String>? blockedUsers,
    int? age,
    String? disease,
    BloodTypeEnum? bloodType,
    GenderEnum? gender,
    int? weight,
    String? imagePath,  // Burada da String? oldu
    int? height,
    String? location,
  }) {
    return UserModel(
      specialization:  specialization ?? this.specialization,
      role: role ?? this.role,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      fcmToken: fcmToken ?? this.fcmToken,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      age: age ?? this.age,
      disease: disease ?? this.disease,
      bloodType: bloodType ?? this.bloodType,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      imagePath: imagePath ?? this.imagePath,
      height: height ?? this.height,
      location: location ?? this.location,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      role: data['role'] != null
          ? RoleEnum.values.firstWhere((e) => e.name == data['role'])
          : RoleEnum.hasta,
      uid: doc.id,
      fullName: data["fullName"] ?? "",

      email: data["email"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      isOnline: data["isOnline"] ?? false,
      lastSeen: data["lastSeen"] ?? Timestamp.now(),
      createdAt: data["createdAt"] ?? Timestamp.now(),
      fcmToken: data["fcmToken"],
      blockedUsers: List<String>.from(data["blockedUsers"] ?? []),
      age: data["age"],
      disease: data["disease"],
      bloodType: data["bloodType"] != null
          ? BloodTypeEnum.values.firstWhere((e) => e.name == data["bloodType"])
          : null,
      gender: data["gender"] != null
          ? GenderEnum.values.firstWhere((e) => e.name == data["gender"])
          : null,
      weight: data["weight"],
      imagePath: data["imagePath"],
      height: data["height"],
      location: data["location"],
      specialization: data['specialization'] as String?,


    );
  }

  Map<String, dynamic> toMap() {
    return {
      'specialization': specialization,
      'role': role.name,
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
      'fcmToken': fcmToken,
      'blockedUsers': blockedUsers,
      'age': age,
      'disease': disease,
      'bloodType': bloodType?.name,
      'gender': gender?.name,
      'weight': weight,
      'imagePath': imagePath,
      'height': height,
      'location': location,
    };
  }
}
