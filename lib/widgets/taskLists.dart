import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/database_helper.dart';
import 'package:todoey_flutter/models/tasks.dart';
import 'package:todoey_flutter/screen/tasks_screen.dart';
import 'package:todoey_flutter/widgets/tasksTiles.dart';

class TaskLists extends StatefulWidget {
  @override
  _TaskListsState createState() => _TaskListsState();
}

class _TaskListsState extends State<TaskLists> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TasksScreen tasksScreen = TasksScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            initialData: [],
            future: dbHelper.getTasks(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskTile(
                      taskTitle: snapshot.data[index].name.toString(),
                      isChecked:
                          snapshot.data[index].isDone == 0 ? false : true,
                      longPressCallback: () async {
                        await dbHelper
                            .deleteTask(snapshot.data[index].name.toString())
                            .then((value) {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TasksScreen()))
                              .then((value) {
                            setState(() {});
                          });
                        });
                      },
                      checkboxCallback: (checkBoxState) async {
                        if (snapshot.data[index].isDone == 0) {
                          await dbHelper
                              .updateTask(
                                  Task(
                                      name:
                                          snapshot.data[index].name.toString(),
                                      isDone: 1),
                                  snapshot.data[index].name.toString())
                              .then((value) {
                            setState(() {});
                          });
                        } else {
                          await dbHelper
                              .updateTask(
                                  Task(
                                      name:
                                          snapshot.data[index].name.toString(),
                                      isDone: 0),
                                  snapshot.data[index].name.toString())
                              .then((value) {
                            setState(() {});
                          });
                        }
                      });
                },
                itemCount: snapshot.data.length,
              );
            }),
      ),
    );
  }
}
