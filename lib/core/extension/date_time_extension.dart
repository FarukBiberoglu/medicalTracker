import 'package:intl/intl.dart';

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

  String get toDateAgo {
    return isToday
        ? 'Today'
        : isYesterday
        ? 'Yesterday'
        : DateFormat('d MMMM, EEEE').format(this);
  }

  String get toTimeAgo {
    final now = DateTime.now().toUtc();
    final utcDateTime = toUtc();

    final difference = now.difference(utcDateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} d';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays ~/ 7)} w';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays ~/ 30)} mo';
    } else {
      return '${(difference.inDays ~/ 365)} y';
    }
  }
}
