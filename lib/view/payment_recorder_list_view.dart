//#region Import

import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_text.dart';
import '../model/list_model.dart';
import '../theme/style_element.dart';
import '../view_model/paymentrecorder_list_view_model.dart';
import '../widgets/list_view_card.dart';
import '../widgets/shimmer_list.dart';

//#endregion

//#region View

class PaymentRecorderListView extends StatefulWidget {
  const PaymentRecorderListView({super.key});

  @override
  State<PaymentRecorderListView> createState() =>
      _PaymentRecorderListViewState();
}

class _PaymentRecorderListViewState extends State<PaymentRecorderListView>
    with AutomaticKeepAliveClientMixin<PaymentRecorderListView> {

  //#region Veriable

  PaymentRecorderListViewModel paymentRecorderListViewModel =
  PaymentRecorderListViewModel();
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
    loadPaymentRecorderList();
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
      itemCount: paymentRecorderListViewModel.paymentRecorderList.length,
      padding: appEdgeInsets.all5,
      itemBuilder: (BuildContext context, int index) {
        item = paymentRecorderListViewModel.paymentRecorderList[index];
        return ListViewCard(item: item, type: ListServices.paymentRecorder);
      },
    );
  }

  //#region ExtFunc

  //#region Load

  Future<void> loadPaymentRecorderList() async {
    getPaymentRecorderList(paymentRecorderListViewModel.reference!)
        .then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _changeLoading();
          paymentRecorderListViewModel.paymentRecorderList = value;
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
    await loadPaymentRecorderList();
  }

//#endregion

//#endregion

}

//#endregion
