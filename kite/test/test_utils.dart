import 'dart:io';
import 'package:path/path.dart' as path;


Future<String> loadFileFixture(String pathName) async{
  final currentDir = Directory.current.path;
  final filePath = path.join(currentDir, pathName);
  final File file = File(filePath);
  return await file.readAsString();
}