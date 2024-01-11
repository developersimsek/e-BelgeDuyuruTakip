import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/style_element.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    AppColorItem appColorItem = AppColorItem();
    AppSizeItem appSizeItem = AppSizeItem();

    return SpinKitRipple(
        color: appColorItem.lightBlue, size: appSizeItem.size100);
  }
}
