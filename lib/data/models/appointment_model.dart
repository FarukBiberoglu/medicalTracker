import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:untitled19/core/enum/appointment_state_enum.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import 'package:untitled19/data/models/user_model.dart';
part 'appointment_model.g.dart';

@HiveType(typeId: 3)
class AppointmentModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String doctorName;
  @HiveField(2)
  final DateTime appointmentDate;
  @HiveField(3)
  final CategoryEnum categoryEnum;
  @HiveField(4)
  final DocumentReference userRef;
  @HiveField(5)
  final UserModel? doktorModel;
  @HiveField(6)
  final UserModel? userModel;
  @HiveField(7)
  final AppointmentStateEnum appointmentStateEnum;
  @HiveField(8)
  final DocumentReference doktorRef;

  AppointmentModel({
    required this.doktorRef,
    this.userModel,
     this.doktorModel,
    this.id,
    required this.doctorName,
    required this.appointmentDate,
    required this.categoryEnum,
    required this.userRef,
    required this.appointmentStateEnum,
  });

  String get specialization =>
      userModel?.specialization != null && userModel!.specialization!.isNotEmpty
          ? userModel!.specialization!
          : "Uzmanlık bilgisi yok";

  static Future<AppointmentModel> fromJson(Map<String, dynamic> json) async {
    final userSnap = await (json['userRef'] as DocumentReference).get();
    final user = UserModel.fromFirestore(userSnap);
    final doktorSnap = await (json['doktorRef'] as DocumentReference).get();
    final doktor = UserModel.fromFirestore(doktorSnap);

    return AppointmentModel(

      appointmentStateEnum: AppointmentStateEnum.values.firstWhere(
            (e) => e.toString() == 'AppointmentStateEnum.${json['appointmentStateEnum']}',
      ),
      userModel: user,
      doktorModel:doktor,
      userRef: json['userRef'] as DocumentReference,
      doktorRef: json['doktorRef'] as DocumentReference,

      id: json['id'] as String?,
      doctorName: json['doctorName'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate']),
      categoryEnum: CategoryEnum.values.firstWhere(
            (e) => e.toString() == 'CategoryEnum.${json['categoryEnum']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentStateEnum': appointmentStateEnum.name,
      'doktorRef': doktorRef,
      'userRef': userRef,
      'id': id,
      'doctorName': doctorName,
      'appointmentDate': appointmentDate.toIso8601String(),
      'categoryEnum': categoryEnum.name,
    };
  }

  AppointmentModel copyWith({
    DocumentReference? doktorRef,
    UserModel? doktorModel,
    String? doctorId,
    DocumentReference? userRef,
    String? id,
    String? doctorName,
    DateTime? appointmentDate,
    CategoryEnum? categoryEnum,
    AppointmentStateEnum? appointmentStateEnum,
    UserModel? userModel,
  }) {
    return AppointmentModel(
      doktorRef: doktorRef ?? this.doktorRef,
      appointmentStateEnum: appointmentStateEnum ?? this.appointmentStateEnum,
      userRef: userRef ?? this.userRef,
      doktorModel: doktorModel ?? this.doktorModel,
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      categoryEnum: categoryEnum ?? this.categoryEnum,
      userModel: userModel ?? this.userModel,
    );
  }
}
