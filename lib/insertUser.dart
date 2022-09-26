import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class InsertUser extends StatefulWidget {
  const InsertUser({Key? key}) : super(key: key);

  @override
  State<InsertUser> createState() => _InsertUserState();
}

class _InsertUserState extends State<InsertUser> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  static const link = 'http://10.0.2.2:3000/users';

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  void insertUser() async {
    if (_key.currentState!.validate()) {
      await http.post(Uri.parse(link), body: {
        "name": name.text,
        "address": address.text
      }, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }).then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New User"),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 20),
            TextFormField(
                controller: name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                )),
            const SizedBox(height: 20),
            TextFormField(
                controller: address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your address',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                )),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: ElevatedButton(
                  onPressed: insertUser, child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
