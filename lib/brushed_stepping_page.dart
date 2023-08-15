import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:usbcan_plugins/widgets.dart';
import 'package:usbcan_plugins/usbcan.dart';

import 'text_slider.dart';

class BrushedSettingPage extends StatefulWidget {
  const BrushedSettingPage({super.key, required this.usbcan});
  final UsbCan usbcan;
  @override
  State<BrushedSettingPage> createState() => _BrushedSettingPageState();
}

enum BrushedSettingPageMode { current, position }

class _BrushedSettingPageState extends State<BrushedSettingPage> {
  int canID = 0;
  BrushedSettingPageMode mode = BrushedSettingPageMode.current;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        HexSwitchField(
            onChanged: (hex) {
              canID = hex.fold<int>(
                  0,
                  (previousValue, element) =>
                      (previousValue << 8 | (0xFF & element)));
            },
            mode: CanWidgetMode.hexMode),
        Row(
          children: [
            Expanded(
              child: TextSlider(
                  text: 'Target',
                  onChanged: (v) {
                    CANFrame.fromIdAndData(
                        canID, Float32List.fromList([v]).buffer.asUint8List());
                  }),
            ),
            DropdownMenu(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: BrushedSettingPageMode.current, label: 'Current'),
                  DropdownMenuEntry(
                      value: BrushedSettingPageMode.position,
                      label: 'Position'),
                ],
                onSelected: (v) {
                  setState(() {
                    mode = v as BrushedSettingPageMode;
                  });
                })
          ],
        ),
        TextSlider(
            text: 'Current Pgain',
            onChanged: (v) {
              sendParameter(0, v);
            }),
        TextSlider(
            text: 'Current Igain',
            onChanged: (v) {
              sendParameter(1, v);
            }),
        TextSlider(
            text: 'Current Dgain',
            onChanged: (v) {
              sendParameter(2, v);
            }),
        TextSlider(
            text: 'Position Pgain',
            onChanged: (v) {
              sendParameter(3, v);
            }),
        TextSlider(
            text: 'Position Igain',
            onChanged: (v) {
              sendParameter(4, v);
            }),
        TextSlider(
            text: 'Position Dgain',
            onChanged: (v) {
              sendParameter(5, v);
            }),
        ElevatedButton(onPressed: () {}, child: const Text('Save')),
      ]),
    );
  }

  void sendParameter(int parameterId, double value) {
    Uint8List id = Uint8List.fromList([parameterId]);
    Float32List floatData = Float32List.fromList([value]);
    Uint8List data = Uint8List.fromList(id + floatData.buffer.asUint8List());
    CANFrame frame = CANFrame.fromIdAndData(
      canID + 2,
      data,
    );
    widget.usbcan.sendFrame(frame);
  }
}
