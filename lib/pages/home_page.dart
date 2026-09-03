import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_practice_thetechbrother/models/posts_model.dart';
import 'package:flutter_rest_api_practice_thetechbrother/pages/second_page.dart';
import 'package:flutter_rest_api_practice_thetechbrother/pages/third_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> getPostsList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> dataList in data) {
        getPostsList.add(PostsModel.fromJson(dataList));
      }
      return getPostsList;
    } else {
      return getPostsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: .center,
          children: [
            DrawerHeader(child: SizedBox()),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              title: Text('P H O T O', style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.photo_outlined),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              title: Text('U S E R', style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.person_2_outlined),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                    itemCount: getPostsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            leading: Text(
                              getPostsList[index].id.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            title: Text(
                              getPostsList[index].title.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Text(getPostsList[index].body.toString()),
                                Row(
                                  mainAxisAlignment: .end,
                                  children: [
                                    Text(
                                      index.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text(
                              getPostsList[index].userId.toString(),
                            ),
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
