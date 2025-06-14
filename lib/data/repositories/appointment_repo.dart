import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class AppointmentRepo {
  Future<List<UserModel>> fetchDoctorNames() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'doktor')
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }
}
