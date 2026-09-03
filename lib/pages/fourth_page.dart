import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FourthPage extends StatefulWidget {
  const new({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    var data;
    Future<void> getUsersApi() async {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
      } else {}
    }

    return Scaffold(
      appBar: AppBar(title: Text('U S E R T W O')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              UsersInfo(
                                title: 'Name',
                                value: data[index]['name'].toString(),
                              ),
                              UsersInfo(
                                title: 'User Name',
                                value: data[index]['username'].toString(),
                              ),
                              UsersInfo(
                                title: 'Email',
                                value: data[index]['email'].toString(),
                              ),
                              UsersInfo(
                                title: 'Address',
                                value: data[index]['address']['street']
                                    .toString(),
                              ),
                              UsersInfo(
                                title: 'Lat',
                                value: data[index]['address']['geo']['lat']
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UsersInfo extends StatelessWidget {
  final String? title, value;
  const UsersInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [Text(title ?? ''), Text(value ?? '')],
    );
  }
}
