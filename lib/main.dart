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
    Colors.amberAccent;

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 139, 184, 71),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 57, 128, 55),
          centerTitle: true,
          title: const Text(appTitle),
        ),
        drawer: const NavigationDrawer(),
        body: const MyCustomForm(),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context,)
            ],
          ),
        ),
      );
}
Widget buildHeader(BuildContext context) => Container(
  color: const Color.fromARGB(255, 139, 184, 71),
  padding: EdgeInsets.only(
    top: MediaQuery.of(context).padding.top,
  ),
  child: Column(
    children: const [
      CircleAvatar(
        radius: 52,
        backgroundImage: NetworkImage(
          'https://media.discordapp.net/attachments/758708402938576897/998587392468463697/zenith_logo_without_bg.png'
        ),
      ),
      SizedBox(height: 12,),
      Text(
        'Futurz Club',
        style: TextStyle(fontSize: 28, color: Colors.white70),
      ),
      Text(
        'futurz.afgji@gmail.com',
        style: TextStyle(fontSize: 16, color: Colors.white24),
      )
    ],
  ),
);

Widget buildMenuItems(BuildContext context) => Column(
      children: [
        ListTile(
          title: const Text(''),
          onTap: () {},
        ),
      ],
    );

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              labelText: 'Enter your Message',
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
              resultantFile,
            });
            ('Response status: ${response.statusCode}');
          },
          child: const Text(insideText),
        ),
      ],
    );
  }
}
