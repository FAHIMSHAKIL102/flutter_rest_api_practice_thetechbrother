import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map dataList in data) {
        PhotosModel photos = PhotosModel(
          title: dataList['title'],
          url: dataList['url'],
          thumbnailUrl: dataList['thumbnailUrl'],
          id: dataList['id'],
          albumId: dataList['albumId'],
        );
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('P H O T O')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No photos found'));
                }

                final items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              items[index].url,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 48);
                              },
                            ),
                          ),
                          title: Text(
                            items[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: SizedBox(
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text('ID: ${items[index].id}'),
                                Text('Album ID: ${items[index].albumId}'),
                                Text('${index + 1}'),
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              items[index].thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_not_supported, size: 40);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosModel {
  String title;
  String url;
  String thumbnailUrl;
  int id;
  int albumId;

  PhotosModel({
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.id,
    required this.albumId,
  });
}
