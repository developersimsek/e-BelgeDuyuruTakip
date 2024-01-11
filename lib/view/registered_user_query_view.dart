//#region Import

import 'package:ebelgeduyurutakip/services/plg_service.dart';
import 'package:ebelgeduyurutakip/widgets/custom_textfield.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_func.dart';
import '../theme/style_element.dart';
import '../definitions/glb_text.dart';
import '../view_model/refistered_user_query_view_model.dart';
import '../widgets/lottie_animation.dart';

//#endregion

//#region Variable

final WebViewController webViewController = WebViewController();

final EInvoiceElementName eInvoiceElementName = EInvoiceElementName();
final OtherEDocumentsElementName otherEDocumentsElementName =
    OtherEDocumentsElementName();

final JavasScriptCommand javasScriptCommand = JavasScriptCommand();
final PermanentText permanentText = PermanentText();
final AppBorderRadius appBorderRadius = AppBorderRadius();
final AppEdgeInsets appEdgeInsets = AppEdgeInsets();
final ErrorMessageText errorMessageText = ErrorMessageText();
final AppColorItem appColorItem = AppColorItem();
final AppSizeItem appSizeItem = AppSizeItem();

final TextEditingController vknTckn = TextEditingController();
final TextEditingController securityCode = TextEditingController();

String _submitFormResponse = "";
String _animationPath = "";
bool _isSubmitForm = false;
bool _isLoading = true;
String _productQueryType = ProductQueryType.eInvoice.name;

//#endregion

//#region View

class RegisteredUserQueryView extends StatefulWidget {
  const RegisteredUserQueryView({super.key});

  @override
  State<RegisteredUserQueryView> createState() =>
      _RegisteredUserQueryViewState();
}

class _RegisteredUserQueryViewState extends State<RegisteredUserQueryView>
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
        initWebView(webViewController, ProductQueryType.eInvoice.baseUrl);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: AppBar(
        title: Text(permanentText.registeredUserQueryViewTitle),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _queryClick,
        backgroundColor: appColorItem.lightBlue,
        splashColor: appColorItem.goldenLightBlue,
        child: LottieAnimationWidget(
          animationPath: AnimationType.search.path,
          width: appSizeItem.size30,
          height: appSizeItem.size30,
        ),
      ),
    );
  }

  //#region Build

  //#region Header

  Padding _buildHeader() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double headerHeight = deviceHeight * 0.20;

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
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeaderRow1() {
    final deviceWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (deviceWidth / 2) - 20;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: appEdgeInsets.top15,
            width: buttonWidth,
            decoration: BoxDecoration(
              color: appColorItem.lightBlue,
              border: const Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Padding(
              padding: appEdgeInsets.horizontal10,
              child: _dropdownButton(),
            )),
        SizedBox(
          width: appSizeItem.size15,
        ),
        Expanded(
            flex: appSizeItem.sizeInt2,
            child: CustomTextField(
                isNumberType: true,
                text: permanentText.textFieldLabelVknTckn,
                maxLength: appSizeItem.sizeInt16,
                controller: vknTckn,
                isTextInputActionGo: false)),
      ],
    );
  }

  Row _buildHeaderRow2() {
    final deviceWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (deviceWidth / 2) - 90;

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
          width: appSizeItem.size88,
        ),
        SizedBox(
            width: buttonWidth + 70,
            child: CustomTextField(
                isNumberType: false,
                text: permanentText.textFieldLabelNameSecurityCode,
                maxLength: appSizeItem.sizeInt16,
                controller: securityCode,
                isTextInputActionGo: true))
      ],
    );
  }

  DropdownButton<String> _dropdownButton() {
    return DropdownButton<String>(
      value: _productQueryType,
      onChanged: _changedProductQueryType,
      iconEnabledColor: appColorItem.white,
      alignment: AlignmentDirectional.topEnd,
      isExpanded: true,
      dropdownColor: appColorItem.lightBlue,
      items: productQueryTypeList(),
      borderRadius: appBorderRadius.allRadius20,
      style: TextStyle(
        color: appColorItem.white,
      ),
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

    if (vknTckn.text.isEmpty || securityCode.text.isEmpty) {
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

  void _changedProductQueryType(String? newValue) {
    ProductQueryType selectedType =
        ProductQueryType.values.firstWhere((type) => type.name == newValue);

    initWebView(webViewController, selectedType.baseUrl);

    _animationPath = "";
    _submitFormResponse = "";

    setState(() {
      _productQueryType = newValue!;
    });
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
    scrollIntoViewAndStyleTransform(webViewController, "");

    if (_isSubmitForm) {
      await _submitFormAndHandleResponse();
    }
  }

  Future<void> _submitFormAndHandleResponse() async {
    Object htmlObject;
    String outerHtml;

    htmlObject = await webViewController
        .runJavaScriptReturningResult(javasScriptCommand.outerHTML);

    outerHtml = htmlObject.toString();

    if (outerHtml.contains(permanentText.formUserRegistered)) {
      _animationPath = AnimationType.successful.path;
      _submitFormResponse = permanentText.formUserRegistered;
    } else if (outerHtml.contains(errorMessageText.formErrorCaptchaCode)) {
      _animationPath = AnimationType.unsuccessful.path;
      _submitFormResponse = errorMessageText.formErrorCaptchaCode;
    } else if (outerHtml.contains(errorMessageText.formNotUserRegistered)) {
      _animationPath = AnimationType.unsuccessful.path;
      _submitFormResponse = errorMessageText.formNotUserRegistered;
    } else {
      _animationPath = AnimationType.unsuccessful.path;
      _submitFormResponse = errorMessageText.serverError;
    }

    _changeIsSubmitForm();

    setState(() {});
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
  securityCode.text = "";
  _submitFormResponse = "";
  _animationPath = "";
  _isSubmitForm = false;
  _isLoading = true;
  _productQueryType=ProductQueryType.eInvoice.name;
}

Future<void> _webViewQuery() async {
  await _setWebViewAttributeValue().then((value) {
    if (_productQueryType == ProductQueryType.eInvoice.name) {
      submitForm(webViewController, eInvoiceElementName.submit,
          isElementFindByName: false);
    } else {
      submitForm(webViewController, eInvoiceElementName.submit,
          isElementFindByName: false);
    }
  });
}

Future<void> _setWebViewAttributeValue() async {
  String jsVknTckn = "", jsCapcthaCode = "", jsCommand;

  String elementAndAttributeCommand =
      JavasScriptCommand().setElementAndAttributeByName;

  if (_productQueryType == ProductQueryType.eInvoice.name) {
    jsVknTckn = elementAndAttributeCommand.setElementNameAndValue(
        eInvoiceElementName.vknTckn, vknTckn.text);

    jsCapcthaCode = elementAndAttributeCommand.setElementNameAndValue(
        eInvoiceElementName.captchaCode, securityCode.text);
  } else {
    jsVknTckn = elementAndAttributeCommand.setElementNameAndValue(
        otherEDocumentsElementName.vknTckn, vknTckn.text);

    jsCapcthaCode = elementAndAttributeCommand.setElementNameAndValue(
        otherEDocumentsElementName.captchaCode, securityCode.text);
  }

  jsCommand = jsVknTckn + jsCapcthaCode;

  await webViewController.runJavaScriptReturningResult(jsCommand);
}

//#endregion