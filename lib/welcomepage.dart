import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

void main() {
  runApp(MaterialApp(
    home: WelcomePage(),
    routes: {
      '/Signup': (context) => SignUpPage(),
      '/Login': (context) => LogInPage(),
    },
  ));
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome From GUSTO University"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
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
            width: 600,
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'GUSTO University',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 23.0,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0),
                    child: Image.asset('assests/gusto.jpg',
                        width: 120.0, height: 120.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '"Transforming Lives through Quality Education"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Signup',
                              arguments: 'to Sign Up page');
                          print('you clicked the Sign Up button');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .lightBlueAccent,
                        ),
                        child: Text('Sign Up'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Login',
                              arguments: 'to LogIn page');
                          print('you clicked the Log In button');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                        ),
                        child: Text('Log In'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
