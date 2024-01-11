//#region Import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/loading.dart';
import 'glb_text.dart';
import 'package:flutter/services.dart';

//#endregion

//#region String

extension StringExtensions on String {
  String removingWhiteSpaceAndCapitalize() {
    return removingWhiteSpace().toLowerCase().capitalize();
  }

  String removingWhiteSpace() {
    return replaceAll("\n", "")
        .replaceAll("\r", "")
        .replaceAll(" +", "")
        .replaceAll("\t", "");
  }

  String capitalize() {
    //TODO: Şuan sadece ilk harfi çeviriyor. Noktadan sonra da büyük harf yapmak gerek.

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String setAttValue(String attName, String attValue) {
    String replaceScript;

    replaceScript = replaceAll("{1}", attName);

    if (attValue.isNotEmpty) {
      replaceScript = replaceScript.replaceAll("{2}", attValue);
    }

    return replaceScript;
  }

  String setElementName(String elementName) {
    String replaceScript;

    replaceScript = replaceAll("{0}", elementName);

    return replaceScript;
  }

  String setElementNameAndValue(String elementName, String attValue,
      [String attName = "value"]) {
    return setElementName(elementName).setAttValue(attName, attValue);
  }

  String stringToHtmlFormat() {
    return decodeUnicodeEscapes().unescapeString();
  }

  String decodeUnicodeEscapes() {
    return replaceAllMapped(
      RegExp(r'\\[Uu]([0-9A-Fa-f]{4})'),
      (match) {
        final hexValue = match.group(1);
        final intValue = int.parse(hexValue!, radix: 16);
        return String.fromCharCode(intValue);
      },
    );
  }

  String unescapeString() {
    return replaceAllMapped(RegExp(r'\\[ntr\\"\\]'), (match) {
      switch (match.group(0)) {
        case r'\n':
          return '\n';
        case r'\t':
          return '\t';
        case r'\r':
          return '\r';
        case r'\\':
          return '\\';
        case r'\"':
          return '\"';
        default:
          return match.group(0).toString();
      }
    });
  }
}

String toShortDateString(DateTime date) {
  DateFormat formatter = DateFormat('dd MMMM yyyy');

  return formatter.format(date);
}

String toLongDateString(DateTime date) {
  DateFormat formatter = DateFormat('dd MMMM yyyy EEEE');

  return formatter.format(date);
}

//#endregion

//#region DateTime

DateTime stringToDateTime(String date) {
  return DateTime.parse(date);
}

//#endregion

//#region Connection

Future<bool> checkConnection() async {
  final List<InternetAddress> result;

  try {
    result = await InternetAddress.lookup(PermanentText().testConnectionUrl);

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }

  return false;
}

//#endregion

//#region Animation

//#region Loading

void loadingShow(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const LoadingWidget();
    },
  );
}

void loadingHide(BuildContext context) {
  Navigator.of(context).pop();
}

//#endregion

//#endregion

//#region SystemChannels

void textInputHide() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

//#endregion