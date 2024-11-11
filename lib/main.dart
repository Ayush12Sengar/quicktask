import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/add_task_screen.dart';
import 'services/parse_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await ParseInit.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthWrapper(), 
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/taskList': (context) => const TaskListScreen(),
        '/addTask': (context) => const AddTaskScreen(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      
      Navigator.pushReplacementNamed(context, '/taskList');
    } else {
      
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
