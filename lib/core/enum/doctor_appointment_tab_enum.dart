


import 'package:untitled19/core/widgets/tabbar/app_tabbar.dart';

enum DoctorAppointmentTabEnum implements IAppTabbarEnum {
  all(displayValue: 'All Request'),
  complete(displayValue: "Complete"),
  cancel(displayValue: 'Canceled');

  const DoctorAppointmentTabEnum({required this.displayValue});

  @override
  final String displayValue;
}

