import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/models/task.dart';

class TaskService {
  
  Future<List<Task>> fetchTasks() async {
    try {
      final query = QueryBuilder<ParseObject>(ParseObject('Task'));
      final ParseResponse response = await query.query();
      if (response.success && response.results != null) {
      
        return response.results!
            .map((taskObj) => Task.fromParseObject(taskObj))
            .toList();
      } else {
        print('Error fetching tasks: ${response.error?.message}');
        return [];
      }
    } catch (e) {
      print('Error during fetch tasks: $e');
      return [];
    }
  }

  
  Future<void> addTask(String title, DateTime dueDate) async {
    try {
      final task = Task(objectId: '', title: title, dueDate: dueDate, status: false);
      final taskObject = task.toParseObject();
      final response = await taskObject.save();
      if (response.success) {
        print('Task added successfully');
      } else {
        print('Error adding task: ${response.error?.message}');
      }
    } catch (e) {
      print('Error during task add: $e');
    }
  }

  
  Future<void> deleteTask(String taskId) async {
    try {
      final task = ParseObject('Task')..objectId = taskId;
      final response = await task.delete();
      if (response.success) {
        print('Task deleted successfully');
      } else {
        print('Error deleting task: ${response.error?.message}');
      }
    } catch (e) {
      print('Error during task deletion: $e');
    }
  }

 
  Future<void> toggleTaskStatus(String taskId, bool status) async {
    try {
      final task = ParseObject('Task')..objectId = taskId;
      task.set<bool>('status', status);
      final response = await task.save();
      if (response.success) {
        print('Task status updated');
      } else {
        print('Error updating task status: ${response.error?.message}');
      }
    } catch (e) {
      print('Error during task status update: $e');
    }
  }
  Future<void> updateTask(String taskId, String title, DateTime dueDate) async {
    try {
      final task = ParseObject('Task')..objectId = taskId;
      task.set<String>('title', title);
      task.set<DateTime>('dueDate', dueDate);
      final response = await task.save();
      if (response.success) {
        print('Task updated successfully');
      } else {
        print('Error updating task: ${response.error?.message}');
      }
    } catch (e) {
      print('Error during task update: $e');
    }
  }
}
