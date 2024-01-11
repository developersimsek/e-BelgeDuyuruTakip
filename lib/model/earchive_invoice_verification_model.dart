//#region Import

//#endregion

//#region Object

class EArchiveInvoiceVerificationModel {
  String vkntckn;
  String no;
  String odenecek;

  EArchiveInvoiceVerificationModel({
    required this.vkntckn,
    required this.no,
    required this.odenecek,
  });

  factory EArchiveInvoiceVerificationModel.fromJson(
      Map<String, String> parsedJson) {
    return EArchiveInvoiceVerificationModel(
        vkntckn: parsedJson['vkntckn'].toString(),
        no: parsedJson['no'].toString(),
        odenecek: parsedJson['odenecek'].toString());
  }
}

//#endregion
