extension DateTimeSetters on DateTime {
  DateTime setHour(int hour) {
    return DateTime(this.year, this.month, this.day, hour, this.millisecond);
  }
}
