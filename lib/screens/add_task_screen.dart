import 'package:flutter/material.dart';
import 'package:quicktask/services/task_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _dueDateController = TextEditingController();
  final TaskService _taskService = TaskService();

  DateTime? _dueDate;

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
        _dueDateController.text = "${_dueDate!.toLocal()}".split(' ')[0]; 
      });
    }
  }

  Future<void> _addTask() async {
    final title = _titleController.text;
    final dueDateStr = _dueDateController.text;

    if (title.isEmpty || dueDateStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a due date')),
      );
      return;
    }

    await _taskService.addTask(title, _dueDate!);
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(labelText: 'Due Date (YYYY-MM-DD)'),
              readOnly: true,
              onTap: () => _pickDueDate(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _addTask, child: const Text('Add Task')),
          ],
        ),
      ),
    );
  }
}
