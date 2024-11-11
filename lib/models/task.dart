import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Task {
  final String objectId;
  final String title;
  final DateTime dueDate;
  final bool status;
  Task({
    required this.objectId,
    required this.title,
    required this.dueDate,
    required this.status,
  });
  ParseObject toParseObject() {
    final task = ParseObject('Task');
    task.set<String>('title', title);
    task.set<DateTime>('dueDate', dueDate);
    task.set<bool>('status', status);
    return task;
  }
  factory Task.fromParseObject(ParseObject parseObject) {
    return Task(
      objectId: parseObject.objectId!,
      title: parseObject.get<String>('title')!,
      dueDate: parseObject.get<DateTime>('dueDate')!,
      status: parseObject.get<bool>('status')!,
    );
  }
}
