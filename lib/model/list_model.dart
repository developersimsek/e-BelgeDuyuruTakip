//#region Import

import '../definitions/glb_func.dart';

//#endregion

//#region ListObject

class ListItemModel{
  String Key;
  String Aciklama;
  String Link;
  DateTime Date;

  ListItemModel({
    required this.Key,
    required this.Aciklama,
    required this.Link,
    required this.Date,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> parsedJson, String key) {
    return ListItemModel(
        Key:key,
        Aciklama:
        parsedJson['Aciklama'].toString().removingWhiteSpaceAndCapitalize(),
        Link: parsedJson['Link'],
        Date: stringToDateTime(parsedJson['Date']));
  }
}

//#endregion