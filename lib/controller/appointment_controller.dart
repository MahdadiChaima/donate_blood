import 'package:donate_blood/view/screens/home_screen.dart';
import 'package:donate_blood/view/widgets/colors.dart';
import 'package:donate_blood/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:donate_blood/view/widgets/colors.dart';
import 'package:donate_blood/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/appointment.dart';
import 'history_controller.dart';

class AppointmentController extends GetxController {
  var hospitalsList = <String>[].obs;
  var nameHospital = RxString('');
  var selectedDate = RxString('');
  var selectedTime = RxString('');
  var availableDates = <String>[].obs;
  var availableTimeSlots = <String>[].obs;
  var selectedDateIndex = RxInt(0);
  var selectedTimeIndex = RxInt(0);

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchHospitals();
    ever(nameHospital, (_) async {
      await fetchAvailableDates(nameHospital.value);
    });
    ever(selectedDate, (_) async {
      await fetchAvailableTimeSlots(
          nameHospital.value, selectedDate.value);
      selectedTime.value = availableTimeSlots.first;
      selectedTimeIndex.value = 0;
      update();
    });
  }

  Future<void> fetchHospitals() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('hospitals').get();
      querySnapshot.docs.forEach((doc) {
        hospitalsList.add(doc.id);
      });
      nameHospital.value = hospitalsList[0];
      await fetchAvailableDates(nameHospital.value);
      update();
    } catch (e) {
      print('Error fetching hospitals: $e');
    }
  }

  Future<void> fetchAvailableDates(String hospitalName) async {
    try {

      print("try fetch ${hospitalName}");
      final querySnapshot = await FirebaseFirestore.instance
          .collection('hospitals')
          .doc(hospitalName)
          .collection('appointments')
          .get();
      availableDates.clear(); // clear previous dates
      querySnapshot.docs.forEach((doc) {
        availableDates.add(doc.id);
      });
      selectedDate.value = availableDates.elementAt(0);
      selectedDateIndex.value = 0; // set the selected date index to the first date
      await fetchAvailableTimeSlots(hospitalName, selectedDate.value); // fetch the available time slots for the selected date
      update();
    } catch (e) {
      print('Error fetching available dates: $e');
    }
  }
  Future<void> fetchAvailableTimeSlots(String hospitalName, String date) async {
    try {
      print('Fetching time slots for $hospitalName and $date');
      final docSnapshot = await FirebaseFirestore.instance
          .collection('hospitals')
          .doc(hospitalName)
          .collection('appointments')
          .doc(date)
          .get();
      final data = docSnapshot.data();
      if (data != null && data.containsKey('time_slots')) {
        final timeSlots = List<String>.from(data['time_slots']);
        availableTimeSlots.assignAll(timeSlots);

      } else {
        availableTimeSlots.clear();
      }
    } catch (e) {
      print('Error fetching available time slots: $e');
    }
    update();
  }

  Future<void> createAppointment (
      String nameHospital, String date, String time) async {
    await FirebaseFirestore.instance
        .collection('usersInformation')
        .doc(token)
        .collection('appointments')
        .add({
      'nameHospital': nameHospital,
      'date': date,
      'time': time,
    }).then((value) async {
      final historyController = HistoryController();
      final newAppointment = Appointment(
        hospitalName: nameHospital,
        appointmentDate: date,
        appointmentTime: time,
      );
      historyController.appointmentList.add(newAppointment);
      historyController.update();
      //await Future.delayed(Duration(seconds: 10));

      CustomSnackbar('Success', "add appointment successfully",
          isSuccess: true);
      Get.to(()=>HomeScreen());
      update();
    }).catchError((onError) {
      CustomSnackbar('Error', onError.toString());
    });
  }
}
