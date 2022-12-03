import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_node/insertUser.dart';
import 'package:flutter_node/models/astronomy.dart';
import 'package:flutter_node/shared/constants.dart';
import 'package:flutter_node/updateUser.dart';
import 'package:http/http.dart' as http;

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
  static const link = Constants.baseURL;
  late AstronomyModel data;

  Future getData() async {
    final http.Response res = await http.get(Uri.parse(link), headers: Constants.headers);
    if (res.statusCode == 200) {
      print(json.decode(res.body));
      data = AstronomyModel.fromJson(json.decode(res.body));
    }
    return data;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Column(
                          children: [
                            buildText(data.location.name),
                            buildText(data.astronomy.astro.sunset),
                            buildText(data.astronomy.astro.sunrise),
                            buildText(data.location.region)
                          ],
                        ),
                        leading: IconButton(
                          onPressed: () => setState(() {
                            // deleteUser(snapshot.data[index].id);
                          }),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            // Pid = snapshot.data[index].id;
                            // Pname = snapshot.data[index].name;
                            // Paddress = snapshot.data[index].address;
                            // Navigator.of(context).pushNamed('update')
                            //     .then((value) => setState(() {}));
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
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed('insert')
            .then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }

  Text buildText(text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }
}
