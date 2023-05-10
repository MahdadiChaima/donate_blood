class Appointment {
  String hospitalName;
  String appointmentDate;
  String appointmentTime;
  Appointment({ required this.hospitalName, required this.appointmentDate, required this.appointmentTime});
  factory Appointment.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw Exception('Appointment data is null');
    }
    final appointmentData = data;
    return Appointment(
      appointmentDate: appointmentData['date'] ?? '',
      hospitalName: appointmentData['nameHospital'] ?? '',
      appointmentTime: appointmentData['time'] ?? '',
    );
  }
  Map<String, dynamic> toJson(context) => {
    'nameHospital': hospitalName,
    'date': appointmentDate,
    'time': appointmentTime,
  };
}
