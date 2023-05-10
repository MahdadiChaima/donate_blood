import 'package:donate_blood/view/widgets/custom_text.dart';
import '../../controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/appointment.dart';
import '../widgets/colors.dart';
import 'home_screen.dart';

class HistoryScreen extends StatelessWidget {
   HistoryController historyController = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: GetBuilder<HistoryController>(
                init: HistoryController(),
                builder: (historyController) => historyController
                        .appointmentList.isEmpty
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => Get.to(() => HomeScreen()),
                                    icon: Icon(Icons.arrow_back_ios_new)),
                                CustomText(index: 1, text: "History"),
                                Text(''),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: historyController.appointmentList.length,
                            itemBuilder: (context, index) {
                              return AppointmentItem(
                                appointment:
                                    historyController.appointmentList[index],
                              );
                            },
                          ),
                        ],
                      )),
          ),
        ),
      ),
    );
  }
}

class AppointmentItem extends StatelessWidget {
  final Appointment appointment;

  const AppointmentItem({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: textFieldCBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryLightColor,
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appointment.hospitalName,
                      index: 3,
                    ),
                    CustomText(
                        index: 2, text: 'Date: ${appointment.appointmentDate}'),
                    CustomText(
                        text: 'Time: ${appointment.appointmentTime}', index: 2),
                  ],
                ),
                Icon(
                  Icons.bloodtype,
                  size: 60,
                  color: primaryColor,
                )
              ],
            ),
          )),
    );
  }
}
