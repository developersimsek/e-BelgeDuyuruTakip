//#region Import

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../definitions/glb_func.dart';
import '../definitions/glb_text.dart';

//#endregion

//TODO: Tüm fonksiyonları try catch ile yönet.

//#region Function

//#region Instance

DatabaseReference? fireBaseInstance(String path) {
  DatabaseReference? reference = null;

  try {
    reference = FirebaseDatabase.instance.ref(path);
  } on FirebaseException catch (ext) {
    print(ext.message);
  } catch (e) {
    print(e.toString());
  }
  return reference;
}

//#endregion

//#region Get

Future<Object?> getData(DatabaseReference reference) async {
  final bool isConnected = await checkConnection();

  if (!isConnected) {
    return ErrorMessageText().isNotConnection;
  }

  try {
    final data = await reference.get();
    if (data.exists) {
      return data.value;
    } else {
      return null;
    }
  } on FirebaseException catch (e) {
    return e.message;
  } catch (e) {
    return e.toString();
  }
}

//#endregion

//#endregion
