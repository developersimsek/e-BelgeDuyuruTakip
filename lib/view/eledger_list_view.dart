//#region Import

import 'package:ebelgeduyurutakip/definitions/glb_enum.dart';
import 'package:flutter/material.dart';
import '../definitions/glb_text.dart';
import '../model/list_model.dart';
import '../theme/style_element.dart';
import '../view_model/eledger_list_view_model.dart';
import '../widgets/list_view_card.dart';
import '../widgets/shimmer_list.dart';

//#endregion

//#region View

class ELedgerListView extends StatefulWidget {
  const ELedgerListView({super.key});

  @override
  State<ELedgerListView> createState() => _ELedgerListViewState();
}

class _ELedgerListViewState extends State<ELedgerListView>
    with AutomaticKeepAliveClientMixin<ELedgerListView> {

  //#region Veriable

  ELedgerListViewModel eLedgerListViewModel = ELedgerListViewModel();
  AppColorItem appColorItem = AppColorItem();
  AppEdgeInsets appEdgeInsets = AppEdgeInsets();
  PermanentText permanentText = PermanentText();

  late ListItemModel item;
  late final ListTile tabController;
  bool _isLoading = true;

  //#endregion

  //#region State

  @override
  void initState() {
    loadELedgerList();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  //#endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: appColorItem.white,
        backgroundColor: appColorItem.lightBlue,
        onRefresh: onRefresh,
        child: _isLoading ? const ShimmerList() : _buildListView(),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: eLedgerListViewModel.eLedgerList.length,
      padding: appEdgeInsets.all5,
      itemBuilder: (BuildContext context, int index) {
        item = eLedgerListViewModel.eLedgerList[index];
        return ListViewCard(
          item: item,
          type: ListServices.eLedger,
        );
      },
    );
  }

  //#region ExtFunc

  //#region Load

  Future<void> loadELedgerList() async {
    getELedgerList(eLedgerListViewModel.reference!).then((getList) {
      if (getList.isNotEmpty) {
        setState(() {
          _changeLoading();
          eLedgerListViewModel.eLedgerList = getList;
        });
      }
    });
  }

  //#endregion

  //#region Change

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> onRefresh() async {
    _changeLoading();
    await loadELedgerList();
  }

//#endregion

//#endregion

}

//#endregion
