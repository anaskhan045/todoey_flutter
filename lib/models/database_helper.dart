import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter/models/tasks.dart';

class DatabaseHelper {
// Open the database and store the reference.
  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'todoy.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE tasks(name TEXT, isDone INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();
    _db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> getTasksNumber() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return taskMap.length;
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');

    return List.generate(taskMap.length, (index) {
      return Task(
        name: taskMap[index]['name'],
        isDone: taskMap[index]['isDone'],
      );
    });
  }

  Future<void> deleteTask(String name) async {
    // Get a reference to the database.
    Database _db = await database();

    // Remove the Dog from the Database.
    await _db.delete(
      'tasks',
      // Use a `where` clause to delete a specific dog.
      where: "name = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }

  Future<bool> updateTask(Task task, String name) async {
    // Get a reference to the database.
    Database _db = await database();

    // Update the given Dog.
    await _db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Dog has a matching id.
      where: "name= ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
    return task.isDone == 0 ? false : true;
  }
}
