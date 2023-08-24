import 'package:flutter/material.dart';
import 'auth.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
    routes: {
      '/Login': (context) => LogInPage(),
    },
  ));
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth(); // Initialize Auth class instance

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> _signUp(BuildContext context) async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user data in your database if needed
      final userData = {'username': username, 'email': email};
      // Save userData to your database

      // Navigate to the login page
      Navigator.pushNamed(context, '/Login');
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 80, // Set the desired height here
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: Text(
                  'GUSTO',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/welcome');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('SignUp'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Signup');
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: const Text('LogIn'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 250,
            height: 400,
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Let’s create a new account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0), // Add padding here
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: _validateEmail,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUp(context);
                        Navigator.pushNamed(context, '/Login', arguments: _emailController);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                    ),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
