//#region Import

import 'package:ebelgeduyurutakip/definitions/glb_func.dart';
import 'package:ebelgeduyurutakip/definitions/glb_text.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//#endregion

//TODO: Tüm fonksiyonları try catch ile yönet.

//#region Share

Future<bool> plgShare(String shareText, String shareSubject) async {
  final result = await Share.shareWithResult('($shareSubject ): $shareText',
      subject: shareSubject);

  if (result.status == ShareResultStatus.success) {
    return true;
  }

  return false;
}

//#endregion

//#region Html

Future<dom.Element?> queryHtmlElement(
    Object htmlObject, String queryHtmlElement) async {
  String html;

  html = htmlObject.toString().stringToHtmlFormat();

  dom.Document htmlParser = parse(html);
  return htmlParser.querySelector(queryHtmlElement);
}

//#endregion

//#region WebView

Future<void> initWebView(
    WebViewController webViewController, String loadRequest) async {
  Uri uri = Uri.parse(loadRequest);

  webViewController.loadRequest(uri);
  webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
}

Future<void> scrollIntoViewAndStyleTransform(
    WebViewController webViewController, String elementName) async {
  String scrollIntoViewCommand, elementAddStyleTransformCommand;
  JavasScriptCommand javasScriptCommand = JavasScriptCommand();

  if (elementName.isEmpty) {
    elementAddStyleTransformCommand =
        javasScriptCommand.elementAddStyleTransformByTagName;
    scrollIntoViewCommand = javasScriptCommand.scrollIntoViewByTagName;
    scrollIntoViewCommand =
        scrollIntoViewCommand.setElementName(javasScriptCommand.imgByTagName);
    elementAddStyleTransformCommand = elementAddStyleTransformCommand
        .setElementNameAndValue(javasScriptCommand.imgByTagName, "", "7");
  } else {
    elementAddStyleTransformCommand =
        javasScriptCommand.elementAddStyleTransform;
    scrollIntoViewCommand = javasScriptCommand.scrollIntoView;
    scrollIntoViewCommand = scrollIntoViewCommand.setElementName(elementName);
    elementAddStyleTransformCommand = elementAddStyleTransformCommand
        .setElementNameAndValue(elementName, "", "5");
  }

  await webViewController
      .runJavaScriptReturningResult(elementAddStyleTransformCommand);

  await webViewController.runJavaScriptReturningResult(scrollIntoViewCommand);
}

Future<void> submitForm(WebViewController webViewController, String elementName,
    {bool isElementFindByName = true}) async {
  String elementClickCommand;

  JavasScriptCommand javasScriptCommand = JavasScriptCommand();
  if (isElementFindByName) {
    elementClickCommand = javasScriptCommand.elementClickByName;
  } else {
    elementClickCommand = javasScriptCommand.elementClick;
  }

  elementClickCommand = elementClickCommand.setElementName(elementName);

  await webViewController.runJavaScriptReturningResult(elementClickCommand);
}
//#endregion

//#region UrlLauncher

Future<bool> plgBrowser(String url) async {
  Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    return false;
  }
  return true;
}

//#endregion

//#region Toast

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
  );
}

//#endregion

//#region Scanner

Future<String?> scanBarcode() async {
  PermanentText permanentText = PermanentText();
  String? qrValue;

  await FlutterBarcodeScanner.scanBarcode(
    permanentText.scannerStringColor,
    permanentText.scannerCancelText,
    true,
    ScanMode.QR,
  ).then((value) {
    if (value.isNotEmpty) {
      qrValue = value;
    } else {
      qrValue = ErrorMessageText().scannerError;
    }
  });

  return qrValue;
}

//#endregion
