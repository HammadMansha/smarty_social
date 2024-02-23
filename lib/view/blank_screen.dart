import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/blank_controller.dart';

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlanKScreenController>(
      init: BlanKScreenController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(),
        );
      },
    );
  }
}
