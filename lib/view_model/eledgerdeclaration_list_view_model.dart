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

class ELedgerDeclarationListViewModel {
  final DatabaseReference ?reference =
      fireBaseInstance(ListServices.eLedgerDeclaration.servicePath);

  List<ListItemModel> eLedgerDeclarationList = [];
}

//#endregion

//#region Get

Future<List<ListItemModel>> getELedgerDeclarationList(
    DatabaseReference reference) async {
  List<ListItemModel> getELedgerDeclarationList = [];
  Map<String, dynamic> getDataMap;
  Map<String, dynamic> itemMap;

  await getData(reference).then((data) {
    if (data != null) {
      if (data is String) {
        //TODO: Yeri doğru mu? View e alınması daha mı mantıklı?
        showToast(data);
      } else {
        getDataMap = Map<String, dynamic>.from(
          data as Map,
        );

        getDataMap.forEach((key, value) {
          itemMap = Map<String, dynamic>.from(
            value as Map,
          );

          getELedgerDeclarationList.add(ListItemModel.fromJson(itemMap,key));
        });
      }
    }
  });

  getELedgerDeclarationList.sort((a, b) {
    return b.Date.compareTo(a.Date);
  });

  return getELedgerDeclarationList;
}

//#endregion
