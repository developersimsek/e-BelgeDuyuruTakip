import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/style_element.dart';

class ShimmerList extends StatelessWidget {
  final int length;
  const ShimmerList({super.key, this.length = 20});

  @override
  Widget build(BuildContext context) {
    AppColorItem appColorItem = AppColorItem();
    AppEdgeInsets appEdgeInsets = AppEdgeInsets();
    AppSizeItem appSizeItem = AppSizeItem();

    //TODO: Shimmer için paket kullanıldı. Paket kullanmadan yap.
    return Shimmer.fromColors(
      baseColor: appColorItem.white60,
      highlightColor: appColorItem.white70,
      child: ListView.builder(
          itemCount: length,
          padding: appEdgeInsets.all5,
          itemBuilder: (context, index) {
            return _buildCard(appColorItem, appSizeItem);
          }),
    );
  }

  Card _buildCard(AppColorItem appColorItem, AppSizeItem appSizeItem) {
    return Card(
      color: appColorItem.white,
      shadowColor: appColorItem.lightBlue,
      surfaceTintColor: appColorItem.white,
      borderOnForeground: true,
      elevation: appSizeItem.size5,
      child: const ListTile(
          title: Text(""), subtitle: Text(""), trailing: Text("")),
    );
  }
}
