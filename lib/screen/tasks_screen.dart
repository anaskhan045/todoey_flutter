import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/database_helper.dart';
import 'package:todoey_flutter/widgets/taskLists.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  final Function getTasksNumber;
  TasksScreen({this.getTasksNumber});
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int taskNumber;
  Future<void> getTasksNumber() async {
    await DatabaseHelper().getTasksNumber().then((value) {
      setState(() {
        taskNumber = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasksNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => AddTaskScreen());
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$taskNumber Tasks',
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TaskLists(),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
