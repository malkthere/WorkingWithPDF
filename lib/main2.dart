import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';


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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async{

    /*// this next 4 line to write a file in temp Directory
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/fileNo_'+_counter.toString());
    print(""+tempDir.toString());
    await file.writeAsString('this file writen as the try No.'+_counter.toString());*/

    /*////////////here we creat a file in side our own Dir in temp folder
    final Directory tempDir = await getTemporaryDirectory();
    final Directory newDirectory =
    Directory('${tempDir.path}/sample_directoryNo'+_counter.toString());

// Always check that the directory exists
    if (await newDirectory.exists() == false) {
      await newDirectory.create();
    }

    final File file = File('${newDirectory.path}/sample_file'+_counter.toString()+'.txt');
    print(""+tempDir.toString());
    await file.writeAsString('this file writen as the try No.'+_counter.toString());*/

   /* //////////////// reading a file from temp
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/fileNo_0');

    final String fileContent = await file.readAsString();
    print(fileContent);*/
   // final appDocuments = await getApplicationDocumentsDirectory();
    //print(appDocuments);
    //print("mazin");
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    File? file;
    FilePickerResult? result;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          if (file != null || result != null) ...[
            if (kIsWeb) ...[
              Image.memory(
                result!.files.first.bytes!,
                height: 177,
                width: 360,
                fit: BoxFit.fill,
              ),
            ] else ...[
              Image.file(file!, height: 177, width: 360, fit: BoxFit.fill),
            ],
            const SizedBox(height: 8),
          ],

          ElevatedButton(
            onPressed: () async {
              try {
                result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  if (!kIsWeb) {
                    file = File(result!.files.single.path!);
                  }
                  setState(() {});
                } else {
                  print("user cancled the picker");
                  // User canceled the picker
                }
              } catch (_) {}
            },
            child: const Text('Pick File'),
          ),

        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
