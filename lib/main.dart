import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_node/insertUser.dart';
import 'package:flutter_node/updateUser.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'insert': (context) => const InsertUser(),
        'update': (context) => const UpdateUser(),
      },
      home: const MyHomePage(),
    );
  }
}

var Pid;
var Pname;
var Paddress;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const link = 'http://10.0.2.2:3000/users';

  Future<List<UserModel>> getUsers() async {
    List<UserModel> list = [];
    final http.Response res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      list = (json.decode(res.body)['result'] as List)
          .map((data) => UserModel.fromJson(data))
          .toList();
    }
    return list;
  }

  void deleteUser(id) async {
    await http.delete(Uri.parse('$link/$id'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(
                              snapshot.data[index].name,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              snapshot.data[index].address,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        leading: IconButton(
                          onPressed: () =>
                              setState(() {
                                deleteUser(snapshot.data[index].id);
                              }),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Pid = snapshot.data[index].id;
                            Pname = snapshot.data[index].name;
                            Paddress = snapshot.data[index].address;
                            Navigator.of(context).pushNamed('update')
                                .then((value) => setState(() {}));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context)
                .pushNamed('insert')
                .then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
