extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now().toUtc();
    final utcDateTime = toUtc();
    return utcDateTime.day == now.day;
  }

  bool get isYesterday {
    final now = DateTime.now().toUtc();
    final utcDateTime = toUtc();
    return utcDateTime.day == now.day - 1;
  }

  bool isSameDay(DateTime other) {
    final utcOther = other.toUtc();
    final utcDateTime = toUtc();
    return utcDateTime.day == utcOther.day &&
        utcDateTime.month == utcOther.month &&
        utcDateTime.year == utcOther.year;
  }
}