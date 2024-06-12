import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newapp/register.dart';

// Step 2: Create model class for response data
class User {
  final String id;

  User({required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
    );
  }
}

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('tokenBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: (Hive.box<String>('tokenBox').containsKey('token'))
            ? DashboardScreen()
            : LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(text: "john.doe@example.com");
  final TextEditingController passwordController =
      TextEditingController(text: "yourSecurePassword");

  Future<void> login(BuildContext context) async {
    try {
      var dio = Dio();
      final response = await dio.post(
        'http://192.168.0.109:3000/api/signin',
        data: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );
      final user = User.fromJson(response.data['userres']);
      await Hive.box<String>('tokenBox').put('token', user.id);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => login(context), child: Text('Login')),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Hive.box<String>('tokenBox').delete('token');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Dashboard'),
            IconButton(
                onPressed: () {
                  Hive.box<String>('tokenBox').delete('token');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                icon: Icon(Icons.add_business))
          ],
        ),
      ),
    );
  }
}
