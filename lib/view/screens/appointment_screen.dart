import 'package:donate_blood/view/widgets/custom_button.dart';
import 'package:donate_blood/view/widgets/custom_snackbar.dart';
import 'package:donate_blood/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/appointment_controller.dart';
import '../../controller/history_controller.dart';
import '../widgets/colors.dart';
import 'home_screen.dart';

class AppointmentScreen extends StatelessWidget {
  final appointmentController = Get.put(AppointmentController());

  // your appointment snapshot

  String? _nameController;
  final _dateController = TextEditingController();
  final _hourController = TextEditingController();



  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            backgroundColor:
                Colors.grey[900], // set your desired background color here
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _hourController.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child:

             Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Get.to(() => HomeScreen()),
                        icon: Icon(Icons.arrow_back_ios)),
                    CustomText(index: 3, text: "add appointment"),
                    Text('')
                  ],
                ),
                SizedBox(
                  height: 140,
                ),


                GetBuilder<AppointmentController>(
                  init: AppointmentController(),
                  builder: (cntrl)=> cntrl.hospitalsList.isEmpty?
                  CircularProgressIndicator(): DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'choose hospital',
                      icon: Icon(
                        Icons.local_hospital_outlined,
                        color: primaryColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    value: cntrl
                        .nameHospital.value, // Change this line.
                    items: cntrl.hospitalsList
                        .map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) async{
                      cntrl.nameHospital.value = value!;
                      await cntrl.fetchAvailableDates(cntrl.nameHospital.value);
                      await cntrl.fetchAvailableTimeSlots(cntrl.nameHospital.value, cntrl.availableDates[cntrl.selectedDateIndex.value]);
                      cntrl.selectedTimeIndex.value = 0;
                      cntrl.update();
                    },
                  ),),//hi
                SizedBox(
                  height: 25,
                ),
               GetBuilder<AppointmentController>(
                 init: AppointmentController(),
                   builder: (cntrl)=> cntrl.availableDates.isEmpty || cntrl.availableDates.length==0?
                   CustomText(index: 2, text: "this hospital is full now you can choose later other time"):DropdownButtonFormField<int>(
                     decoration: InputDecoration(
                       labelText: 'Choose date',
                       icon: Icon(
                         Icons.date_range,
                         color: primaryColor,
                       ),
                       border: OutlineInputBorder(),
                     ),
                     value: cntrl.selectedDateIndex.value,
                     items: List<DropdownMenuItem<int>>.generate(cntrl.availableDates.length, (index) {
                       return DropdownMenuItem<int>(
                         value: index,
                         child: Text(cntrl.availableDates[index]),
                       );
                     }),
                     onChanged: (selectedIndex) async{
                       cntrl.selectedDateIndex.value = selectedIndex!;
                       await cntrl.fetchAvailableTimeSlots(cntrl.nameHospital.value, cntrl.availableDates[cntrl.selectedDateIndex.value]);
                       cntrl.update();

                     },
                   )
               ),

                SizedBox(
                  height: 25,
                ),
                GetBuilder<AppointmentController>(
                    init: AppointmentController(),
                    builder: (cntrl)=>
                    cntrl.availableTimeSlots.length==0?CustomText(index: 2, text: "this hospital is full now you can choose later other time"):
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Choose Time',
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: primaryColor,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      value: cntrl.selectedTimeIndex.value,
                      items: List<DropdownMenuItem<int>>.generate(cntrl.availableTimeSlots.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(cntrl.availableTimeSlots[index]),
                        );
                      }),
                      onChanged: (selectedIndex) async{
                        cntrl.selectedTimeIndex.value = selectedIndex!;
                        cntrl.selectedTime.value=cntrl.availableTimeSlots[selectedIndex];
                        print(cntrl.selectedTime.value);
                        cntrl.update();
                      },
                    )
                ),
                SizedBox(
                  height: 140,
                ),
                CustomButton(
                    text: 'Save',
                    onPressed: () {
                      if(appointmentController.hospitalsList.length>0 && appointmentController.availableDates.length>0 && appointmentController.availableTimeSlots.length>0)
                      {
                        appointmentController.createAppointment(
                            appointmentController.nameHospital.value,
                            appointmentController.selectedDate.value,
                            appointmentController.selectedTime.value);
                         var history=HistoryController();
                        history.update();
                      print('byy');}
                      else
                      {
                        CustomSnackbar("Error", "should add all appointment data to add");
                      }
                      },
                    sideColor: primaryColor,
                    primary: primaryColor,
                    onPrimary: Colors.white),
              ],
            )

        ),
      ),
    );
  }
}
