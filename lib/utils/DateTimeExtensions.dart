extension DateTimeSetters on DateTime {
  DateTime setHour(int hour) {
    return DateTime(this.year, this.month, this.day, hour, this.millisecond);
  }

  DateTime setDay(int day) {
    return DateTime(this.year, this.month, day, this.hour, this.millisecond);
  }
}
