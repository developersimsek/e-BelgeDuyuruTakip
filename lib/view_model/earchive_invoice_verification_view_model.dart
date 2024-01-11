//#region Import
import '../definitions/glb_text.dart';
import '../model/earchive_invoice_verification_model.dart';
import '../services/plg_service.dart';

//#endregion

//#region ViewModel

class HtmlElementName {
  String vknTckn = "SATICIVKN";
  String invoiceId = "FATURAID";
  String amount = "ODTUTAR";
  String captchaCode = "captcha_code";
  String imgCode = "imgcf";
  String submit = "submit";
}

Future<EArchiveInvoiceVerificationModel> scanQrCode() async {
  Map<String, String> getDataMap;
  EArchiveInvoiceVerificationModel? qrValue;

/*  String jsonValue = '{"vkntckn":"21106818108", "avkntckn":"1111111111 ", "senaryo":"EARSIVFATURA", "tip":"ISTISNA", "tarih":"2023-11-09", "no":"EAR2023000000010", "ettn":"b7b6415c-890c-4b17-845a-888705d18373", "parabirimi":"EUR", "malhizmettoplam":"6.69", "kdvmatrah(0.0)":"6.69", "hesaplanankdv(0.0)":"0.00", "vergidahil":"6.69", "odenecek":"3680"}';
  getDataMap = Map<String, String>.from(
    json.decode(jsonValue) as Map,
  );
  qrValue = EArchiveInvoiceVerificationModel.fromJson(getDataMap);

  return qrValue!;*/

  return scanBarcode().then((value) {
    if (value != ErrorMessageText().scannerError) {
      getDataMap = Map<String, String>.from(
        value as Map,
      );

      qrValue = EArchiveInvoiceVerificationModel.fromJson(getDataMap);

      return qrValue!;
    } else {
      showToast(value!);
      return Future.value(null);
    }
  });
}

//#endregion
