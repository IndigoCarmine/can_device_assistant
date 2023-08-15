# can_device_assistant

incomplete

It is a flutter application that can be used to control the CAN bus of my circuit board. It can set PID parameters and send Target value.
My boards use the following CAN formt.

Base ID: any (is a maltiple of 0x10)

Can ID - Base ID | Data | Description
--- | --- | ---
0 | float32 4 bytes | Target value
1 | byte | Current Mode or Position Mode etc. (motor specific)
2 | byte + float32 4 bytes | set PID parameters (motor specific)
3 | (Device Output) |  Callback data from device (motor specific) 


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
