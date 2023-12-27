import 'package:adv_5_government_app/modules/view/hompage/screen/homepage.dart';
import 'package:flutter/material.dart';

import 'modules/view/detailpage/screens/detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail': (context) => const DetailPage(),
      },
    ),
  );
}
