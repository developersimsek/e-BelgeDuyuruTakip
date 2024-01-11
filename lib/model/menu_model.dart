//#region Import

import 'package:flutter/material.dart';
import '../view/earchive_invoice_verification_view.dart';
import '../view/evoucher_verification_view.dart';
import '../view/registered_user_query_view.dart';

//#endregion

//#region MenuObject

class MenuList {
  List<dynamic> list = [
    {
      'id': 0,
      'title': 'e-Arşiv Fatura Doğrula',
      'icon': const Icon(Icons.manage_search_outlined),
      'path': const EArchiveInvoiceVerificationView(),
    },
    {
      'id': 1,
      'title': 'e-SMM Doğrula',
      'icon': const Icon(Icons.manage_search_outlined),
      'path': const EVoucherVerificationView(),
    },
    {
      'id': 2,
      'title': 'Mükellef Sorgula',
      'icon': const Icon(Icons.person_search_outlined),
      'path': const RegisteredUserQueryView(),
    },
  ];
}

//#endregion