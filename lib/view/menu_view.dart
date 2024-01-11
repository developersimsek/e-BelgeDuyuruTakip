//#region Import

import 'package:flutter/material.dart';
import '../theme/style_element.dart';
import '../model/menu_model.dart';

//#endregion

//#region View

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    AppColorItem appColorItem = AppColorItem();
    AppHeightItem appHeightItem = AppHeightItem();
    AppWithItem appWithItem = AppWithItem();
    AppSizeItem appSizeItem = AppSizeItem();

    return Drawer(
      child: Column(
        children: [
          Container(
            height: appHeightItem.height200,
            color: appColorItem.lightBlue,
            width: appWithItem.width500,
            child: Icon(
              Icons.person,
              size: appSizeItem.size100,
              color: appColorItem.white,
            ),
          ),
          _buildListView(),
        ],
      ),
    );
  }

  ListView _buildListView() {
    AppEdgeInsets appEdgeInsets = AppEdgeInsets();

    return ListView.builder(
        padding: appEdgeInsets.all5,
        shrinkWrap: true,
        itemCount: MenuList().list.length,
        itemBuilder: (BuildContext context, int index) {
          var menuItem = MenuList().list[index];

          return _drawerCardBuild(menuItem);
        });
  }

  Card _drawerCardBuild(menuItem) {
    AppColorItem appColorItem = AppColorItem();

    return Card(
      color: appColorItem.white,
      shadowColor: appColorItem.lightBlue,
      surfaceTintColor: appColorItem.white,
      child: ListTile(
        title: Text(
          menuItem['title'],
          style: TextStyle(
              color: appColorItem.black, fontSize: AppSizeItem().size15),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => menuItem['path']));
        },
        leading: menuItem['icon'],
        iconColor: appColorItem.lightBlue,
      ),
    );
  }
}

//#endregion
