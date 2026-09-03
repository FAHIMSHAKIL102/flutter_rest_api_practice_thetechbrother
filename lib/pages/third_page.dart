import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_practice_thetechbrother/models/users_model.dart';
import 'package:http/http.dart' as http;

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    List<UsersModel> usersList = [];
    Future<List<UsersModel>> getUsersApi() async {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> userDataList in data) {
          usersList.add(UsersModel.fromJson(userDataList));
        }
        return usersList;
      } else {
        return usersList;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("U S E R")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No User Data');
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container( decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                              ),
                          child: Column(
                            children: [
                              UserInfo(
                                title: snapshot.data![index].name.toString(),
                                value: snapshot.data![index].email.toString(),
                                address: snapshot.data![index].address!.city
                                    .toString(),
                                useName: snapshot.data![index].username.toString(),
                              ),
                              UserInfo(
                                title: snapshot.data![index].username.toString(),
                                value: snapshot.data![index].address!.geo!.lat
                                    .toString(),
                                address: snapshot.data![index].address!.street
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

class UserInfo extends StatelessWidget {
  final String title;
  final String value;
  final String address;
  final String? useName;

  const UserInfo({
    super.key,
    required this.title,
    required this.value,
    required this.address,
    this.useName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title),
          Column(children: [Text(value), Text(address), Text(useName ?? '')]),
        ],
      ),
    );
  }
}
