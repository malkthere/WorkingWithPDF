import 'dart:io';
import 'main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

 class Textfiles {

   readTextFile() async{
    final Directory tempDir = await getTemporaryDirectory();
    print(tempDir);

    final File file = File('${tempDir.path}/file_picker/a text file 005.txt');

    final String fileContent = await file.readAsString();
  //  final List<Future<String>> fileContent = await file.readAsLines();

    print(fileContent);


    return(fileContent);

  }
   Future<String> readTextFile2(File? filepath) async{
    final Directory tempDir = await getTemporaryDirectory();
    print(tempDir);

    //final File file = File(path);

    final String fileContent = await filepath!.readAsString();

    print(fileContent.toString());

    x=fileContent;

    return(fileContent);


  }
  saveTextFile(String filename, String containt) async{
    // this next 4 line to write a file in temp Directory
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('/storage/emulated/0/Documents/'+filename+".text");
    print(""+tempDir.toString());
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      print("no permistiom");
      await Permission.storage.request();
    }
    await file.writeAsString(containt);

  }

  creatDir(String dirname) async {

    ////////////here we creat a file in side our own Dir in temp folder
    final Directory tempDir = await getTemporaryDirectory();
    final Directory newDirectory = Directory('/storage/emulated/0/'+dirname);

// Always check that the directory exists
    if (await newDirectory.exists() == false) {
      await newDirectory.create();
    }

    final File file = File('${newDirectory.path}/sample_file.txt');
    print(""+tempDir.toString());
    await file.writeAsString('this file writen as the try ');
  }void

  getthepath() async {

// Put cache files in this directory
    final temporaryDirectory = await getTemporaryDirectory();

    print("the temporaryDirectory is :");
    print(temporaryDirectory);
// For files that our app uses but are not exposed to the user
    final appSupport = await getApplicationSupportDirectory();
    print(" the appSupport is :");
    print(appSupport);

    // For user-generated files
    final appDocuments = await getApplicationDocumentsDirectory();
    print("the appDocuments is :");
    print(appDocuments);

  }

}