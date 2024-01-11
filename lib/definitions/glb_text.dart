class PermanentText {
  String appFullName = 'e-Belge Duyuru Takip';
  String testConnectionUrl = 'www.google.com';
  String textFieldLabelNameVknTckn = 'Satıcı VKN/TCKN';
  String textFieldLabelNameInvoiceNo = 'e-Fatura No';
  String textFieldLabelNameReceiptNo = 'e-SMM No';
  String textFieldLabelNameAmount = 'Ödenecek Tutar';
  String textFieldLabelNameGrossAmount = 'Brüt Ücret';
  String textFieldLabelNameSecurityCode = 'Güvenlik Kodu';
  String buttonQueryText = 'DOĞRULA';
  String scannerStringColor = '#000000';
  String scannerCancelText = 'VAZGEÇ';
  String registeredUserQueryViewTitle = 'Mükellef Sorgula';
  String textFieldLabelVknTckn = 'VKN/TCKN';
  String formUserRegistered = "Mükellef kayıtlıdır.";

}

class ErrorMessageText {
  String isNotConnection = 'İnternet bağlantısı bulunamadı.';
  String emptyFieldError = 'Lütfen boş alanları doldurunuz.';
  String htmlParseError = 'Html parse işleminde hata oluştu.';
  String serverError = 'Sunucuya erişim sağlanamadı.';
  String scannerError = "QR Okumada bir sorun oluştu: ";
  String formCriteriaError = "Sorgulama kriteri hatası, Lütfen Değerleri Kontrol Ediniz! ";
  String formNotRegisteredInvoice = "Fatura Sistemde Kayıtlı Değildir!";
  String formNotRegisteredVoucher = "Serbest Meslek Makbuzu Sistemde Kayıtlı Değildir!";
  String formNotUserRegistered = "Arama işlemi sonucunda kayıt bulunamadı!";
  String formErrorCaptchaCode= "Güvenlik kodu hatalı, lütfen kontrol ediniz!";
  String FirebaseError= "Güvenlik kodu hatalı, lütfen kontrol ediniz!";
}

class JavasScriptCommand {
  String scrollIntoView =
      "document.getElementsByName('{0}')[0].scrollIntoView();";
  String scrollIntoViewByTagName =
      "document.getElementsByTagName('{0}')[0].scrollIntoView();";
  String elementAddStyleTransform =
      "document.getElementsByName('{0}')[0].style.transform = 'scale({1})'";
  String elementAddStyleTransformByTagName =
      "document.getElementsByTagName('{0}')[0].style.transform = 'scale({1})'";
  String outerHTML = "window.document.firstElementChild.outerHTML;";
  String setElementAndAttribute =
      "document.getElementById('{0}').setAttribute('{1}', '{2}');";
  String setElementAndAttributeByName =
      "document.getElementsByName('{0}')[0].setAttribute('{1}', '{2}');";
  String elementClick = "document.getElementById('{0}').click();";
  String elementClickByName = "document.getElementsByName('{0}')[0].click();";
  String querySuccessfulHtmlElement = 'div[id="showSorgusonuc"] center';
  String queryErrorHtmlElement = 'div[id="errordiv"]';
  String imgByTagName = 'img';
}
