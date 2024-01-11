enum ListServices { eDocument, eLedger, eLedgerDeclaration, paymentRecorder }

extension ListServicesEnum on ListServices {
  String get name {
    return ["e-Belge", "e-Defter", "e-Beyanname", "ÖKC"][index];
  }

  String get baseUrl {
    return [
      "https://ebelge.gib.gov.tr",
      "https://www.edefter.gov.tr",
      "https://ebeyanname.gib.gov.tr",
      "https://ynokc.gib.gov.tr"
    ][index];
  }

  String get baseSortUrl {
    return [
      "ebelge.gib.gov.tr",
      "edefter.gov.tr",
      "ebeyanname.gib.gov.tr",
      "ynokc.gib.gov.tr"
    ][index];
  }

  String get servicePath {
    return [
      "EDocument",
      "ELedger",
      "ELedgerDeclaration",
      "PaymentRecorder"
    ][index];
  }
}

enum VerifyServices {
  eArchiveInvoice,
  eVoucher,
  eInvoiceRegisteredUserQuery,
  eArchiveInvoiceRegisteredUserQuery,
  eWaybillRegisteredUserQuery,
  eVoucherRegisteredUserQuery,
  eReceiptRegisteredUserQuery
}

extension VerifyServicesServicesEnum on VerifyServices {
  String get name {
    return [
      "e-Arşiv Fatura Doğrulama",
      "e-SMM Doğrulama",
      "e-Fatura Mükellef Sorgulama",
      "e-Arşiv Mükellef Sorgulama",
      "e-İrsaliye Mükellef Sorgulama",
      "e-SMM Mükellef Sorgulama",
      "e-MM Mükellef Sorgulama"
    ][index];
  }

  String get baseUrl {
    return [
      "https://ebelge.gib.gov.tr/earsivsorgula.php",
      "https://ebelge.gib.gov.tr/esmmsorgula.php",
      "https://sorgu.efatura.gov.tr/kullanicilar/xliste.php",
      "https://sorgu.efatura.gov.tr/earsivkullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/eirsaliyekullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/esmmkullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/emustahsilkullanicilar/img.php"
    ][index];
  }
}

enum ProductQueryType {
  eInvoice,
  eArchive,
  eWaybill,
  eVoucher,
  eReceipt
}

extension ProductQueryTypeEnum on ProductQueryType {
  String get name {
    return [
      "e-Fatura",
      "e-Arşiv",
      "e-İrsaliye",
      "e-SMM",
      "e-MM"
    ][index];
  }

  String get baseUrl {
    return [
      "https://sorgu.efatura.gov.tr/kullanicilar/xliste.php",
      "https://sorgu.efatura.gov.tr/earsivkullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/eirsaliyekullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/esmmkullanicilar/yliste.php",
      "https://sorgu.efatura.gov.tr/emustahsilkullanicilar/yliste.php"
    ][index];
  }
}

enum AnimationType { successful, unsuccessful, verifyButton,search }

extension Type on AnimationType {
  String get path {
    return [
      "assets/animation/successful-animation.json",
      "assets/animation/unsuccessful-animation.json",
      "assets/animation/verify-animation-white.json",
      "assets/animation/search-animation-white.json"
    ][index];
  }
}
