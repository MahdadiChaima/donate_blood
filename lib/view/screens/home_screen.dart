import 'package:donate_blood/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_container.dart';
import 'package:get/get.dart';

import 'appointment_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            CustomContainer(path:"img/user information.png" ,title:'User Information' ,onPressed: () {
              Get.back();
              Get.to(()=>ProfileScreen());
            }),
            SizedBox(height: 30,),
            CustomContainer(path:"img/appointment.png" ,title:'Appointment' ,onPressed: (){Get.to(()=>AppointmentScreen());}),
            SizedBox(height: 30,),
            CustomContainer(path:"img/history.png" ,title:'History' ,onPressed: (){Get.to(()=>HistoryScreen());}),
          ],
        ),
      ),
    );
  }
}
