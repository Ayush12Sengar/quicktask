import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {
 
  Future<bool> signUp(String username, String password, String email) async {
    try {
      final user = ParseUser(username, password, email);
      final response = await user.signUp();
      if (response.success) {
        return true;
      } else {
        print('Sign up failed: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('Error during sign up: $e');
      return false;
    }
  }
 Future<bool> login(String username, String password) async {
    try {
      final user = ParseUser(username, password, null);
      final response = await user.login();
      if (response.success) {
        return true;
      } else {
        print('Login failed: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }
Future<void> logout() async {
    try {
     
      final currentUser = await ParseUser.currentUser();
      if (currentUser != null) {
        await currentUser.logout();
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
