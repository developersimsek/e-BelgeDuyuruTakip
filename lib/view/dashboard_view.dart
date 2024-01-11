//#region Import

import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_text.dart';
import 'eledgerdeclaration_list_view.dart';
import 'eledger_list_view.dart';
import 'payment_recorder_list_view.dart';
import 'edocument_list_view.dart';
import 'menu_view.dart';

//#endregion

//#region View

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ListServices.values.length,
      child: Scaffold(
        drawer: const MenuView(),
        extendBody: true,
        appBar: AppBar(
          title: Text(PermanentText().appFullName),
          bottom: _tabBarCreate(),
        ),
        body: _tabBarView(),
      ),
    );
  }
}

//#endregion

//#region ExtFunc

TabBar _tabBarCreate() {
  return TabBar(
    tabs: ListServices.values
        .map((e) => Tab(
              text: e.name,
            ))
        .toList(),
  );
}

TabBarView _tabBarView() {
  return const TabBarView(children: [
    EDocumentListView(),
    ELedgerListView(),
    ELedgerDeclarationListView(),
    PaymentRecorderListView(),
  ]);
}

//#endregion
