import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/appointment.dart';
import '../view/widgets/colors.dart';

class HistoryController extends GetxController{
  late RxList<QueryDocumentSnapshot> appointments;
  List<Appointment> appointmentList=[];
  Future<List<QueryDocumentSnapshot>> getHistories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('usersInformation')
        .doc(token)
        .collection('appointments')
        .get();
    update();
    return snapshot.docs;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    var appointments = await getHistories();
    appointments.forEach((appointment) {
      appointmentList.add(Appointment.fromMap(appointment.data() as Map<String, dynamic>));
    });
    update();
  }
}