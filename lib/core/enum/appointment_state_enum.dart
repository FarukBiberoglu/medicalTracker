enum AppointmentStateEnum {
  pending('Your appointment is pending.'),
  accept('Your appointment is confirmed.'),
  reject('Your appointment request was\nnot accepted.');

  final String displayName ;
  const AppointmentStateEnum(this.displayName);


}