
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as fpath;
import 'package:path_provider/path_provider.dart';

class StorageService{

  StorageService();

  Future<Directory> _getBaseDir() async{
    return await getApplicationDocumentsDirectory();
  }

  Future<void> write(String key, String value) async{
    final directory = await _getBaseDir();
    String path = fpath.join(directory.path, key);
    await Isolate.run(() async{
      final file = File(path);
      await file.writeAsString(value);
    });
  }

  Future<String> read(String key) async{
    final directory = await _getBaseDir();
    String path = fpath.join(directory.path, key);
    return await Isolate.run(() async{
      final file = File(path);
      return await file.readAsString();
    });
  }


}