import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/database_helper.dart';
import 'package:todoey_flutter/models/tasks.dart';
import 'package:todoey_flutter/screen/tasks_screen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 35.0,
                ),
              ),
              TextField(
                onChanged: (newText) {
                  newTaskTitle = newText;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 5.0))),
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  if (newTaskTitle != null) {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    await dbHelper.insertTask(Task(name: newTaskTitle));
                  }
                  print('the new task is added');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TasksScreen())).then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
