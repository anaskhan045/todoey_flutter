import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile({
    this.taskTitle,
    this.isChecked,
    this.checkboxCallback,
    this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      title: Text(
        taskTitle,
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 30.0,
          color: Colors.red,
        ),
        onPressed: () async {
          await longPressCallback();
        },
      ),
    );
  }
}
