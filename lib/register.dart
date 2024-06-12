import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _academicYearController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Dio dio = Dio();

  void _registerUser() async {
    try {
      print({
        'email': _emailController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'faculty': _facultyController.text,
        'section': _sectionController.text,
        'regno': _regNoController.text,
        'dob': _dobController.text,
        'academic_year': _academicYearController.text,
        'student_id': _studentIdController.text,
        'password': _passwordController.text,
      });
      Response response =
          await dio.post('http://192.168.0.109:3000/api/signup', data: {
        'email': _emailController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'faculty': _facultyController.text,
        'section': _sectionController.text,
        'regno': _regNoController.text,
        'dob': _dobController.text,
        'academic_year': _academicYearController.text,
        'student_id': _studentIdController.text,
        'password': _passwordController.text,
      });
      Navigator.of(context).pop();
      print(response.data);
      // Handle response accordingly
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Add user failed')));
    } catch (e) {
      print('Error occurred: $e');
      // Handle error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _facultyController,
              decoration: InputDecoration(labelText: 'Faculty'),
            ),
            TextField(
              controller: _sectionController,
              decoration: InputDecoration(labelText: 'Section'),
            ),
            TextField(
              controller: _regNoController,
              decoration: InputDecoration(labelText: 'Registration Number'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: _academicYearController,
              decoration: InputDecoration(labelText: 'Academic Year'),
            ),
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
