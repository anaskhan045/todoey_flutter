class Task {
  String name;
  int isDone;

  Task({
    this.name,
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
    };
  }
}
