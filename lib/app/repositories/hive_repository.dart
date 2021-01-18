import 'dart:async';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

@Injectable()
class HiveRepository extends Disposable {
  Completer<Box> instance = Completer<Box>();

  HiveRepository() {
    init();
  }

  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.openBox('db').then(instance.complete);
  }

  Future<void> delete(String key) async {
    var box = await instance.future;
    box.delete(key);
  }

  Future<T> get<T>(String key) async {
    var box = await instance.future;
    return box.get(key);
  }

  Future<void> put<T>(String key, T value) async {
    var box = await instance.future;
    return box.put(key, value);
  }

  @override
  void dispose() {}
}
