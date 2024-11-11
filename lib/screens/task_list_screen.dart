import 'package:flutter/material.dart';
import 'package:quicktask/services/task_service.dart';
import 'package:quicktask/models/task.dart';
import 'package:quicktask/screens/edit_task_screen.dart'; 

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskService _taskService = TaskService();
  late Future<List<Task>> _taskList;

  @override
  void initState() {
    super.initState();
    _taskList = _taskService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/addTask'), 
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.dueDate.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        task.status ? Icons.check_box : Icons.check_box_outline_blank,
                      ),
                      onPressed: () {
                        _taskService.toggleTaskStatus(task.objectId, !task.status);
                        setState(() {}); 
                      },
                    ),
                   
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _taskService.deleteTask(task.objectId);
                        setState(() {});
                      },
                    ),
                  
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
