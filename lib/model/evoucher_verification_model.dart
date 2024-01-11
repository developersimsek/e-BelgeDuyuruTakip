//#region Import

//#endregion

//#region Object

class EVoucherVerificationModel {
  String vkntckn;
  String no;
  String brutucret;

  EVoucherVerificationModel({
    required this.vkntckn,
    required this.no,
    required this.brutucret,
  });

  factory EVoucherVerificationModel.fromJson(
      Map<String, String> parsedJson) {
    return EVoucherVerificationModel(
        vkntckn: parsedJson['vkntckn'].toString(),
        no: parsedJson['no'].toString(),
        brutucret: parsedJson['brutucret'].toString());
  }
}

//#endregion
