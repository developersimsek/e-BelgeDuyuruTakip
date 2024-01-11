//#region Import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'definitions/glb_option.dart';
import 'definitions/glb_text.dart';
import 'definitions/firebase_options.dart';
import 'theme/custom_theme.dart';
import 'view/dashboard_view.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

//#endregion

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initOneSignal();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EDocumentAnnouncementTracking());
}

class EDocumentAnnouncementTracking extends StatelessWidget {
  const EDocumentAnnouncementTracking({super.key});

  @override
  Widget build(BuildContext context) {
    String appName = PermanentText().appFullName;
    String dateFormat = Options().dateFormat;

    // TODO: Tarih formatları (intl paketi kullanıldı.) için app initialize olurken eklemek gerekiyor.
    initializeDateFormatting(dateFormat);
    Intl.defaultLocale = dateFormat;

    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme().themeData,
      home: const DashBoard(),
    );
  }
}

Future<void> initOneSignal() async {
  String appId = Options().appId;
  OneSignal.initialize(appId);
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    event.preventDefault();
    event.notification.display();
  });

  OneSignal.Notifications.requestPermission(true);
}
