//#region Import

import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';

//#endregion

//#region ViewModel

class EInvoiceElementName {
  String vknTckn = "search_string";
  String captchaCode = "captcha_code";
  String submit = "ara";
}

class OtherEDocumentsElementName {
  String vknTckn = "ara";
  String captchaCode = "captcha_code";
  String submit = "ara";
}

List<DropdownMenuItem<String>> productQueryTypeList() {
  final List<String> productQueryTypeList =
  ProductQueryType.values.map((e) => e.name).toList();

  return productQueryTypeList.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
}

//#endregion