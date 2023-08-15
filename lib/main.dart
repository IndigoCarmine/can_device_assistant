import 'package:can_device_assistant/brushed_stepping_page.dart';
import 'package:can_device_assistant/stepper_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:usbcan_plugins/usbcan.dart';

final usbcan = UsbCan();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Can Device Assistant',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BasePage());
  }
}

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  Widget _body = const StartPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Assistant'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('BrushedMotorSetting'),
              onTap: () {
                _body = BrushedSettingPage(usbcan: usbcan);
                setState(() {});
              },
            ),
            ListTile(
              title: const Text('StepperMotorSetting'),
              onTap: () {
                _body = StepperSettingPage(usbcan: usbcan);
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: _body,
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () async {
        bool isConnected = await usbcan.connectUSB();
        //show snackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isConnected ? 'Connected' : 'Not Connected'),
            ),
          );
        }
      },
      child: const Text('Connect to USBCAN'),
    ));
  }
}
