import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node/main.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var link = 'http://10.0.2.2:3000/users/$Pid';

  @override
  void initState() {
    nameController = TextEditingController(text: Pname);
    addressController = TextEditingController(text: Paddress);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  void updateUser() async {
    if (_key.currentState!.validate()) {
      await http.post(Uri.parse(link), body: {
        "name": nameController.text,
        "address": addressController.text
      }, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }).then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 20),
            TextFormField(
                controller: nameController,
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
                controller: addressController,
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
                  onPressed: updateUser, child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
