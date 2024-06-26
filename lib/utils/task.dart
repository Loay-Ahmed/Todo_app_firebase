class Task {
  Task({required this.task}) {
    id = count;
    count++;
  }

  static int count = 0;
  late int id;
  final String task;

  void printInfo() {}
}
