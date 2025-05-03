extension DateTimeFormatter on DateTime {
  String formatDate({bool date=false}) {
    final now = DateTime.now();
    final isToday = now.year == year && now.month == month && now.day == day;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hourStr = twoDigits(hour);
    final minuteStr = twoDigits(minute);

    if (!date && isToday) {
      return '$hourStr:$minuteStr';
    }

    const monthNames = [
      '',
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic',
    ];

    final monthStr = monthNames[month];
    return '$day $monthStr, $hourStr:$minuteStr';
  }
}
