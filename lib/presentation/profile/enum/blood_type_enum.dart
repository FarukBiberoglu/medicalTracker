enum BloodTypeEnum {
  APositive('A+'),
  ANegative('A-'),
  BPositive('B+'),
  BNegative('B-'),
  ABPositive('AB+'),
  ABNegative('AB-'),
  OPositive('O+'),
  ONegative('O-');

  final String value;
  const BloodTypeEnum(this.value);

  @override
  String toString() => value;
}