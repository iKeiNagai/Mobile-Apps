import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileScreen({super.key});

  void _changePassword(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'New Password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newPassword = _passwordController.text;
                if (newPassword.isNotEmpty) {
                  try {
                    await _auth.currentUser?.updatePassword(newPassword);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password changed successfully'),
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to change password: $e'),
                      ),
                    );
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email: ${_auth.currentUser?.email ?? 'No user'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(context), 
              child: Text("Change Password"))
          ],
        ),
      ),
    );
  }
}
