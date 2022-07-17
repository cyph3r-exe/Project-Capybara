import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

final myController1 = TextEditingController();
final myController2 = TextEditingController();
final myController3 = TextEditingController();
const insideText = 'Pick File';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Tech For Good';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Full Name',
            ),
            controller: myController1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Class and Section',
            ),
            controller: myController2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Admission Number',
            ),
            controller: myController3,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result == null) return;
            final resultantFile = result.files.first;
            var url = Uri.parse('https://example.com/whatsit/create');
            var response = await http.post(url, body: {
              Text(myController1.text),
              Text(myController2.text),
              Text(myController3.text),
            });
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');

            print(await http.read(Uri.parse('https://example.com/foobar.txt')));
          },
          child: const Text(insideText),
        ),
      ],
    );
  }
}
