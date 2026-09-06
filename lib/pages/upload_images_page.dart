import 'package:flutter/material.dart';

class UploadImagesPage extends StatefulWidget {
  const UploadImagesPage({super.key});

  @override
  State<UploadImagesPage> createState() => _UploadImagesPageState();
}

class _UploadImagesPageState extends State<UploadImagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            GestureDetector(
              child: Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(child: Text('Pick Image')),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purpleAccent,
                ),
                child: Center(child: Text('Upload')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
