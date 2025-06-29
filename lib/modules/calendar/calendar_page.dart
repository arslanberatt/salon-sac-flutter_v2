import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('Takvim')),
    );
  }
}
