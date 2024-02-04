import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Picker cc')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (file != null || result != null) ...[
            if (kIsWeb) ...[
              Image.memory(
                result!.files.first.bytes!,
                height: 350,
                width: 350,
                fit: BoxFit.fill,
              ),
            ] else ...[
              Image.file(file!, height: 150, width: 150, fit: BoxFit.fill),
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
                  // User canceled the picker
                }
              } catch (_) {}
            },
            child: const Text('Pick File'),
          ),
        ]),
      ),
    );
  }
}