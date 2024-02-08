import 'dart:io';

import 'package:filemanagment/textfiles.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';
String x="";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Textfiles fileobj = Textfiles();

late String initialfilecontaint="";
    late Future<String> filecontaint;

    TextEditingController newnote=TextEditingController();
    TextEditingController filename=TextEditingController();
    TextEditingController dirName=TextEditingController();


    @override
    Widget build(BuildContext context) {
      File? file;
      FilePickerResult? result;

      return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(x),
            ElevatedButton(
              onPressed: () async {
                  // x=filecontaint as String;

                try {
                  result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                  if (!kIsWeb) {
                    file = File(result!.files.single.path!);
                    filecontaint = (await fileobj.readTextFile2(file)) as Future<String>;
                     //initialfilecontaint=filecontaint;
                   // x='${filecontaint}'.toString();


                    }

                  } else {
                    print("user cancled the picker");
                    // User canceled the picker
                  }

                } catch (_) {}
                super.setState(()  {

                });
                },
              child: const Text('Pick a Text file File'),
            ),

            TextField(
              controller: filename,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'file Name',
                hintText: 'Enter the a file to name to save the note to ',
              ),
            ),
            TextField(
              controller: newnote,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a note',
                hintText: 'Enter your Note overe here',
              ),
            ),
            ElevatedButton(
              onPressed: () async {

                fileobj.saveTextFile(filename.text, newnote.text);
                setState(() {
                  x=newnote.text;
                  newnote.text="";
                  filename.text="";


                });
              },
              child: const Text('save a text'),
            ),
            TextField(
              controller: dirName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'file Name',
                hintText: 'Enter the a file to name to save the note to ',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                fileobj.creatDir(dirName.text);
              },
              child: const Text('create Dir'),
            ),
            ElevatedButton(
              onPressed: () async {
                fileobj.getthepath();
              },
              child: const Text('get the path'),
            ),


          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              filecontaint=fileobj.readTextFile();
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

