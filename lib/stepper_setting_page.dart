import 'package:flutter/material.dart';
import 'package:usbcan_plugins/usbcan.dart';

class StepperSettingPage extends StatefulWidget {
  const StepperSettingPage({super.key, required this.usbcan});
  final UsbCan usbcan;
  @override
  State<StepperSettingPage> createState() => _StepperSettingPageState();
}

class _StepperSettingPageState extends State<StepperSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
