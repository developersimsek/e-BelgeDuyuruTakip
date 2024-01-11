//#region Import

import 'package:ebelgeduyurutakip/view/earchive_invoice_verification_view.dart';
import 'package:flutter/material.dart';
import '../definitions/glb_enum.dart';
import '../definitions/glb_func.dart';
import '../definitions/glb_text.dart';
import '../services/plg_service.dart';
import '../theme/style_element.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//#endregion

//#region Widget

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required this.item,
    required this.type,
  });

  final dynamic item;
  final ListServices type;

  @override
  Widget build(BuildContext context) {
    AppColorItem appColorItem = AppColorItem();
    AppSizeItem appSizeItem = AppSizeItem();
    return Card(
      color: appColorItem.white,
      shadowColor: appColorItem.lightBlue,
      surfaceTintColor: appColorItem.white,
      borderOnForeground: true,
      elevation: appSizeItem.size5,
      child: _buildListTile(appColorItem, appSizeItem, context),
    );
  }

  Slidable _buildListTile(AppColorItem appColorItem, AppSizeItem appSizeItem,
      BuildContext context) {
    AppSizeItem appSizeItem = AppSizeItem();

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              backgroundColor: appColorItem.lightBlue,
              foregroundColor: appColorItem.white,
              icon: Icons.share_outlined,
              onPressed:  (context) {
                _notificationShare();
              }),
          SlidableAction(
              backgroundColor: appColorItem.goldenLightBlue,
              foregroundColor: appColorItem.white,
              icon: Icons.attach_file_outlined,
              onPressed: (context) {
                _showBrowserUrl();
              })
        ],
      ),
      child: ListTile(
          title: Text(toShortDateString(item.Date),
              style: TextStyle(
                  color: appColorItem.lightBlue,
                  fontSize: appSizeItem.size17,
                  fontWeight: FontWeight.w600)),
          subtitle: Text(
            //TODO: Açıklamada 'Tıklayınız' var ise bunu ButtonText yapılabilir mi?
            item.Aciklama,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            _buildModal(context);
          },
          trailing: Text(
            type.baseSortUrl,
            style: TextStyle(
                color: appColorItem.grey,
                fontSize: appSizeItem.size10,
                fontWeight: FontWeight.w400),
          )),
    );
  }

//#region ExtFunc

  void _buildModal(BuildContext context) {
    AppEdgeInsets appEdgeInsets = AppEdgeInsets();
    AppSizeItem appSizeItem = AppSizeItem();
    AppBorderRadius appBorderRadius = AppBorderRadius();

    final deviceWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: appSizeItem.size05,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: appBorderRadius.topRadius30),
              child: Column(
                children: [
                  _buildCustomDivider(appEdgeInsets.top10, appSizeItem.size50),
                  _buildModalHeader(),
                  Padding(
                    padding: appEdgeInsets.modalDividerPadding,
                    child: _buildCustomDivider(appEdgeInsets.zero, deviceWidth),
                  ),
                  _buildModalBody(appEdgeInsets),
                ],
              ),
            ),
          );
        });
  }

  Container _buildCustomDivider(EdgeInsets margin, double width) {
    AppHeightItem appHeightItem = AppHeightItem();
    AppBorderRadius appBorderRadius = AppBorderRadius();
    AppColorItem appColorItem = AppColorItem();

    return Container(
      margin: margin,
      height: appHeightItem.height3,
      width: width,
      decoration: BoxDecoration(
          color: appColorItem.white60,
          borderRadius: appBorderRadius.allRadius5),
    );
  }

  Padding _buildModalHeader() {
    AppEdgeInsets appEdgeInsets = AppEdgeInsets();
    AppSizeItem appSizeItem = AppSizeItem();
    AppColorItem appColorItem = AppColorItem();

    return Padding(
      padding: appEdgeInsets.horizontal10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(toLongDateString(item.Date),
              style: TextStyle(
                  color: appColorItem.lightBlue,
                  fontSize: appSizeItem.size22,
                  fontWeight: FontWeight.w600)),
          IconButton(
            padding: appEdgeInsets.left20,
            alignment: Alignment.centerRight,
            onPressed: () {
              _showBrowserUrl();
            },
            icon: const Icon(Icons.attachment_outlined),
            iconSize: appSizeItem.size20,
            color: appColorItem.lightBlue,
          ),
          IconButton(
            onPressed: () {
              _notificationShare();
            },
            icon: const Icon(Icons.share_outlined),
            iconSize: appSizeItem.size20,
            color: appColorItem.lightBlue,
          ),
        ],
      ),
    );
  }

  Expanded _buildModalBody(AppEdgeInsets appEdgeInsets) {
    return Expanded(
      child: Padding(
        padding: appEdgeInsets.modalEdgeInsets,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: IntrinsicHeight(
            child: Text(
              item.Aciklama,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showBrowserUrl() {
    return plgBrowser(type.baseUrl + item.Link);
  }

  Future<bool> _notificationShare() =>
      plgShare(item.Aciklama, toLongDateString(item.Date));

//#endregion
}

//#endregion
