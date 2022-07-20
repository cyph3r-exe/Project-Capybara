import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io' as io;

void main() => runApp(const MyApp());

final myController1 = TextEditingController();
final myController2 = TextEditingController();
final myController3 = TextEditingController();
const insideText = 'Pick File';
final ImagePicker _picker = ImagePicker();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '#TechForGood';
    const TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 24,
    );

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
              buildMenuItems(
                context,
              )
            ],
          ),
        ),
      );
}

Widget buildHeader(BuildContext context) => Container(
      color: const Color.fromARGB(224, 92, 206, 140),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://media.discordapp.net/attachments/758708402938576897/998587392468463697/zenith_logo_without_bg.png'),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Futurz Club',
            style: TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
          Text(
            'futurz.afgji@gmail.com',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          )
        ],
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Arial',
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6)),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 150,
                  backgroundImage: NetworkImage(
                      'https://media.discordapp.net/attachments/758708402938576897/998628585453666404/Futurz_Initiative_Without_BG.png?width=499&height=499'),
                )
              ],
            ),
          )
        ],
      ),
    );

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
          0.1,
          0.4,
          0.6,
          0.9,
        ],
        colors: [
          Color.fromARGB(255, 89, 255, 213),
          Color.fromARGB(255, 113, 255, 137),
          Color.fromARGB(255, 89, 255, 103),
          Colors.teal,
        ],
      )),
      child: Column(
        children: [
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
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if (image == null) return ;
              
              final bytes = await io.File(image.path).readAsBytes();
              String img64 = base64Encode(bytes);

              var url =
                  Uri.parse('https://rocky-garden-39346.herokuapp.com/upload');
              var response = await http.post(url, body: {
                'student_name': myController1.text,
                'student_class': myController2.text,
                'student_quote': myController3.text,
                'image_data': img64
              });
              print('Response status: ${response.statusCode}');
            },
            child: const Text(insideText),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Text(
              '“Progress is impossible without change, and those who cannot change their minds cannot change anything.”',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(153, 46, 44, 44)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            child: Text(
              'Developed by',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(153, 46, 44, 44)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: Text(
              'Futurz Club AFGJI',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(153, 46, 44, 44)),
            ),
          ),
        ],
      ),
    );
  }
}
