//#region Import
import '../definitions/glb_text.dart';
import '../model/evoucher_verification_model.dart';
import '../services/plg_service.dart';

//#endregion

//#region ViewModel

class HtmlElementName {
  String vknTckn = "SATICIVKN";
  String receiptId = "SMMID";
  String amount = "BRUTUCRET";
  String captchaCode = "captcha_code";
  String imgCode = "imgcf";
  String submit = "submit";
}

Future<EVoucherVerificationModel> scanQrCode() async {
  Map<String, String> getDataMap;
  EVoucherVerificationModel? qrValue;

/*  String jsonValue = '{"vkntckn":"1111111111","avkntckn":"1111111111","tarih":"2022-08-17","no":"GIB2022000000001","ettn":"05e37a73-8c10-46d0-878c-6f7c60834525","parabirimi":"TRY","brutucret":"1000.00","tahsilkdv":"90.00","kdvtevkifat":"90.00","gvstopaj":"200.00","kdvtutari":"180.00","netucret":"800.00","tahsilat":"890.00"}';
  getDataMap = Map<String, String>.from(
    json.decode(jsonValue) as Map,
  );
  qrValue = EReceiptVerificationModel.fromJson(getDataMap);

  return qrValue!;*/

  return scanBarcode().then((value) {
    if (value != ErrorMessageText().scannerError) {
      getDataMap = Map<String, String>.from(
        value as Map,
      );

      qrValue = EVoucherVerificationModel.fromJson(getDataMap);

      return qrValue!;
    } else {
      showToast(value!);
      return Future.value(null);
    }
  });
}

//#endregion