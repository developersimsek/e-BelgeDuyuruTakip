//#region Import

import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_text.dart';
import '../model/list_model.dart';
import '../services/fb_service.dart';
import '../services/plg_service.dart';

//#endregion

//#region ViewModel

class EDocumentListViewModel {
  final DatabaseReference? reference =
      fireBaseInstance(ListServices.eDocument.servicePath);

  List<ListItemModel> eDocumentList = [];
}

Future<List<ListItemModel>> getEDocumentList(
    DatabaseReference reference) async {
  if (reference == null) {
    showToast(ErrorMessageText().FirebaseError);
    return [];
  }

  try {
    final data = await getData(reference);

    if (data != null && data is String) {
      showToast(data);
      return [];
    }

    final getDataMap = Map<String, dynamic>.from(data as Map);

    final eDocumentList = getDataMap.entries
        .map((entry) => ListItemModel.fromJson(
            Map<String, dynamic>.from(entry.value), entry.key))
        .toList();

    eDocumentList.sort((a, b) => b.Date.compareTo(a.Date));

    return eDocumentList;
  } catch (e) {
    showToast(e.toString());
    return [];
  }
}

//#endregion
