import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'addnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student's records",
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  TextEditingController fifth = TextEditingController();
  TextEditingController sixth = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Records');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
              snapshot.value.toString(); // {subtitle: webfun, title: subscribe}

          g = v.replaceAll(
              RegExp("{|}|Batch: |Name: |Email: |Phone number: |Address: "),
              "");
          g.trim();

          l = g.split(',');

          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: SingleChildScrollView(
                    // Wrap content in SingleChildScrollView
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0), // Add padding here
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: second,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0), // Add padding here
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: third,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Batch',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0), // Add padding here
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: fourth,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0), // Add padding here
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: fifth,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0), // Add padding here
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: sixth,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Address',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.lightBlueAccent,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await upd();
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.lightBlueAccent,
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.grey[300],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l[1],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Batch: ${l[2]}", // Add extra text field 1
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Email: ${l[3]}", // Add extra text field 2
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Phone number: ${l[3]}", // Add extra text field 2
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      // Add more additional fields as needed
                    ],
                  ),
                  subtitle: Text(
                    "Address: ${l[4]}", // Add extra text field 3
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("Records/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "Name": second.text,
      "Batch": third.text,
      "Email": fourth.text,
      "Phone number": fifth.text,
      "Address": sixth.text,
    });
    second.clear();
    third.clear();
    fourth.clear();
    fifth.clear();
    sixth.clear();
  }
}
