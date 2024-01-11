//#region Import

import 'package:ebelgeduyurutakip/services/plg_service.dart';
import 'package:ebelgeduyurutakip/widgets/custom_textfield.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_func.dart';
import '../model/evoucher_verification_model.dart';
import '../theme/style_element.dart';
import '../definitions/glb_text.dart';
import '../view_model/evoucher_verification_view_model.dart';
import '../widgets/lottie_animation.dart';

//#endregion

//#region Variable

final WebViewController webViewController = WebViewController();

final HtmlElementName elementName = HtmlElementName();

final JavasScriptCommand javasScriptCommand = JavasScriptCommand();
final PermanentText permanentText = PermanentText();
final AppBorderRadius appBorderRadius = AppBorderRadius();
final AppEdgeInsets appEdgeInsets = AppEdgeInsets();
final ErrorMessageText errorMessageText = ErrorMessageText();
final AppColorItem appColorItem = AppColorItem();
final AppSizeItem appSizeItem = AppSizeItem();

final TextEditingController vknTckn = TextEditingController();
final TextEditingController invoiceNo = TextEditingController();
final TextEditingController amount = TextEditingController();
final TextEditingController securityCode = TextEditingController();

String _submitFormResponse = "";
String _animationPath = "";
bool _isSubmitForm = false;
bool _isLoading = true;

//#endregion

//#region View

class EVoucherVerificationView extends StatefulWidget {
  const EVoucherVerificationView({super.key});

  @override
  State<EVoucherVerificationView> createState() =>
      _EVoucherVerificationViewState();
}

class _EVoucherVerificationViewState
    extends State<EVoucherVerificationView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  //#region State

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadingShow(context);

      if (await checkConnection()) {
        initWebView(webViewController, VerifyServices.eVoucher.baseUrl);
        _setWebViewNavigationDelegate();
      } else {
        loadingHide(context);
        _changeIsLoading();
        showToast(errorMessageText.isNotConnection);
      }
    });
  }

  @override
  void dispose() {
    _disposeState();
    super.dispose();
  }

  //#endregion

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appColorItem.lightBlue,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _scanQrCode();
              },
              icon: const Icon(Icons.qr_code_scanner_outlined))
        ],
        title: Text(VerifyServices.eVoucher.name),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  //#region Build

  //#region Header

  Padding _buildHeader() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double headerHeight = deviceHeight * 0.27;

    return Padding(
      padding: appEdgeInsets.horizontal10,
      child: Container(
        height: headerHeight,
        color: appColorItem.lightBlue,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderRow1(),
              _buildHeaderRow2(),
              _buildHeaderRow3(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeaderRow1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: appSizeItem.sizeInt2,
          child: CustomTextField(
              isNumberType: true,
              text: permanentText.textFieldLabelNameVknTckn,
              maxLength: appSizeItem.sizeInt11,
              controller: vknTckn,
              isTextInputActionGo: false),
        ),
        SizedBox(
          width: appSizeItem.size15,
        ),
        Expanded(
            flex: appSizeItem.sizeInt2,
            child: CustomTextField(
                isNumberType: false,
                text: permanentText.textFieldLabelNameReceiptNo,
                maxLength: appSizeItem.sizeInt16,
                controller: invoiceNo,
                isTextInputActionGo: false)),
      ],
    );
  }

  Row _buildHeaderRow2() {
    return Row(
      children: [
        Expanded(
          flex: appSizeItem.sizeInt2,
          child: CustomTextField(
              isNumberType: true,
              text: permanentText.textFieldLabelNameGrossAmount,
              maxLength: appSizeItem.sizeInt0,
              controller: amount,
              isTextInputActionGo: false),
        ),
        SizedBox(
          width: appSizeItem.size15,
        ),
        Expanded(
          flex: appSizeItem.sizeInt2,
          child: CustomTextField(
              isNumberType: false,
              text: permanentText.textFieldLabelNameSecurityCode,
              maxLength: appSizeItem.sizeInt0,
              controller: securityCode,
              isTextInputActionGo: true,
              onSubmitted: _onSubmitted),
        ),
      ],
    );
  }

  Row _buildHeaderRow3() {
    final deviceWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (deviceWidth / 2) - 20;

    return Row(
      children: [
        IgnorePointer(
          child: SizedBox(
            width: buttonWidth,
            height: 54.5,
            child: Padding(
              padding: appEdgeInsets.top10,
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
          ),
        ),
        SizedBox(
          width: appSizeItem.size15,
        ),
        SizedBox(
          width: buttonWidth,
          child: Padding(
            padding: appEdgeInsets.top10,
            child: ElevatedButton.icon(
              onPressed: _queryClick,
              label: Text(
                permanentText.buttonQueryText,
                style: TextStyle(
                    color: appColorItem.white,
                    fontSize: appSizeItem.size15,
                    letterSpacing: appSizeItem.size015,
                    fontWeight: FontWeight.w600),
              ),
              icon: LottieAnimationWidget(
                animationPath: AnimationType.verifyButton.path,
                width: appSizeItem.size35,
                height: appSizeItem.size35,
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(appColorItem.black)),
            ),
          ),
        )
      ],
    );
  }

  //#endregion

  //#region Body

  Flexible _buildBody() {
    return Flexible(
      flex: 1,
      child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: appBorderRadius.topRadius30, color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: appEdgeInsets.all20,
                  child: Column(
                    children: [
                      Text(
                        _submitFormResponse,
                        style: TextStyle(
                            fontSize: appSizeItem.size15,
                            fontWeight: FontWeight.w400),
                      ),
                      LottieAnimationWidget(
                        animationPath: _animationPath,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  //#endregion

  //#endregion

  //#region ExtFunc

  //#region Control

  Future<bool> _validateFields() async {
    bool iskConnection = await checkConnection();

    if (!iskConnection) {
      return Future.error(errorMessageText.isNotConnection);
    }

    if (vknTckn.text.isEmpty ||
        invoiceNo.text.isEmpty ||
        amount.text.isEmpty ||
        securityCode.text.isEmpty) {
      return Future.error(errorMessageText.emptyFieldError);
    }

    return true;
  }

  //#endregion

  //#region Click

  void _setWebViewNavigationDelegate() {
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) async {
        _completedWebViewQuery().then((value) async {
          if (_isLoading) {
            loadingHide(context);
            _changeIsLoading();
          }
        });
      },
    ));
  }

  void _onSubmitted(String submitted) {
    _queryClick();
  }

  Future<void> _queryClick() async {
    textInputHide();
    _changeIsSubmitForm();
    _validateFields().then((value) async {
      loadingShow(context);
      _changeIsLoading();
      _webViewQuery().then((value) async {});
    }).catchError((err) {
      showToast(err);
    });
  }

  Future<void> _completedWebViewQuery() async {
    scrollIntoViewAndStyleTransform(webViewController, elementName.imgCode);

    if (_isSubmitForm) {
      await _submitFormAndHandleResponse();
    }
  }

  Future<void> _submitFormAndHandleResponse() async {
    Object htmlObject;

    htmlObject = await webViewController
        .runJavaScriptReturningResult(javasScriptCommand.outerHTML);

    queryHtmlElement(htmlObject, javasScriptCommand.querySuccessfulHtmlElement)
        .then((successfulElement) {
      if (successfulElement == null) {
        queryHtmlElement(htmlObject, javasScriptCommand.queryErrorHtmlElement)
            .then((errorElement) {
          _animationPath = AnimationType.unsuccessful.path;
          _submitFormResponse = errorElement!.text.isEmpty
              ? errorMessageText.serverError
              : errorElement.text;
        });
      } else if (successfulElement.text == errorMessageText.formCriteriaError ||
          successfulElement.text.contains(errorMessageText.formNotRegisteredVoucher)) {
        _animationPath = AnimationType.unsuccessful.path;
        _submitFormResponse = successfulElement.text;
      } else {
        _animationPath = AnimationType.successful.path;
        _submitFormResponse = successfulElement.text;
      }
    });

    _changeIsSubmitForm();

    setState(() {});
  }

  Future<void> _scanQrCode() async {
    EVoucherVerificationModel result = await scanQrCode();

    setState(() {
      vknTckn.text = result.vkntckn;
      amount.text = result.brutucret;
      invoiceNo.text = result.no;
    });
  }

//#endregion

//#endregion
}

//#endregion

//#region ExtFunc

//#region Change

void _changeIsSubmitForm() {
  _isSubmitForm = !_isSubmitForm;
}

void _changeIsLoading() {
  _isLoading = !_isLoading;
}

//#endregion

void _disposeState() {
  vknTckn.text = "";
  invoiceNo.text = "";
  amount.text = "";
  securityCode.text = "";
  _submitFormResponse = "";
  _animationPath = "";
  _isSubmitForm = false;
  _isLoading = true;
}

Future<void> _webViewQuery() async {
  await _setWebViewAttributeValue().then((value) {
    submitForm(webViewController, elementName.submit);
  });
}

Future<void> _setWebViewAttributeValue() async {
  String jsInvoiceId,
      jsVknTckn,
      jsAmount,
      jsCapcthaCode,
      jsCommand,
      amountFormat;
  String elementAndAttributeCommand =
      JavasScriptCommand().setElementAndAttribute;
  amountFormat = amount.text.replaceAll(".", "").replaceAll(",", ".");

  jsVknTckn = elementAndAttributeCommand.setElementNameAndValue(
      elementName.vknTckn, vknTckn.text);

  jsInvoiceId = elementAndAttributeCommand.setElementNameAndValue(
      elementName.receiptId, invoiceNo.text);

  jsAmount = elementAndAttributeCommand.setElementNameAndValue(
      elementName.amount, amountFormat);
  jsCapcthaCode = elementAndAttributeCommand.setElementNameAndValue(
      elementName.captchaCode, securityCode.text);

  jsCommand = jsVknTckn + jsInvoiceId + jsAmount + jsCapcthaCode;

  await webViewController.runJavaScriptReturningResult(jsCommand);
}

//#endregion