//#region Import

import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_text.dart';
import '../model/list_model.dart';
import '../theme/style_element.dart';
import '../view_model/eledgerdeclaration_list_view_model.dart';
import '../widgets/list_view_card.dart';
import '../widgets/shimmer_list.dart';

//#endregion

//#region View

class ELedgerDeclarationListView extends StatefulWidget {
  const ELedgerDeclarationListView({super.key});

  @override
  State<ELedgerDeclarationListView> createState() =>
      _ELedgerDeclarationListViewState();
}

class _ELedgerDeclarationListViewState extends State<ELedgerDeclarationListView>
    with AutomaticKeepAliveClientMixin<ELedgerDeclarationListView> {
  //#region Veriable

  ELedgerDeclarationListViewModel eLedgerDeclarationListViewModel =
  ELedgerDeclarationListViewModel();
  AppEdgeInsets appEdgeInsets = AppEdgeInsets();
  AppColorItem appColorItem = AppColorItem();
  PermanentText permanentText = PermanentText();

  late ListItemModel item;
  late final ListTile tabController;
  bool _isLoading = true;

  //#endregion

  //#region State

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    loadELedgerDeclarationList();
    super.initState();
  }

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
      itemCount: eLedgerDeclarationListViewModel.eLedgerDeclarationList.length,
      padding: appEdgeInsets.all5,
      itemBuilder: (BuildContext context, int index) {
        item = eLedgerDeclarationListViewModel.eLedgerDeclarationList[index];
        return ListViewCard(
          item: item,
          type: ListServices.eLedgerDeclaration,
        );
      },
    );
  }

  //#region ExtFunc

  //#region Load

  Future<void> loadELedgerDeclarationList() async {
    getELedgerDeclarationList(eLedgerDeclarationListViewModel.reference!)
        .then((getList) {
      if (getList.isNotEmpty) {
        setState(() {
          _changeLoading();
          eLedgerDeclarationListViewModel.eLedgerDeclarationList = getList;
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
    await loadELedgerDeclarationList();
  }

//#endregion

//#endregion

}

//#endregion
