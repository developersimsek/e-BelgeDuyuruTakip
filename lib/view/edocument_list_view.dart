//#region Import

import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../model/list_model.dart';
import '../definitions/glb_text.dart';
import '../theme/style_element.dart';
import '../view_model/edocument_list_view_model.dart';
import '../widgets/list_view_card.dart';
import '../widgets/shimmer_list.dart';

//#endregion

//#region View

class EDocumentListView extends StatefulWidget {
  const EDocumentListView({super.key});

  @override
  State<EDocumentListView> createState() => _EDocumentListViewState();
}

class _EDocumentListViewState extends State<EDocumentListView>
    with AutomaticKeepAliveClientMixin<EDocumentListView> {
  //#region Veriable

  EDocumentListViewModel eDocumentListViewModel = EDocumentListViewModel();
  AppEdgeInsets appEdgeInsets = AppEdgeInsets();
  AppColorItem appColorItem = AppColorItem();
  PermanentText permanentText = PermanentText();

  late ListItemModel item;
  late final ListTile tabController;
  bool _isLoading = true;

  //#endregion

  //#region State

  @override
  void initState() {
    loadEDocumentList();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  //#endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        color: appColorItem.white,
        backgroundColor: appColorItem.lightBlue,
        child: _isLoading ? const ShimmerList() : _buildListView(),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: eDocumentListViewModel.eDocumentList.length,
        padding: appEdgeInsets.all5,
        itemBuilder: (BuildContext context, int index) {
          item = eDocumentListViewModel.eDocumentList[index];
          return ListViewCard(
            item: item,
            type: ListServices.eDocument,
          );
        });
  }

  //#region ExtFunc

  //#region Load

  Future<void> loadEDocumentList() async {
    getEDocumentList(eDocumentListViewModel.reference!).then((getList) {
      if (getList.isNotEmpty) {
        setState(() {
          _changeLoading();
          eDocumentListViewModel.eDocumentList = getList;
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
    await loadEDocumentList();
  }

  //#endregion

  //#endregion
}

//#endregion
