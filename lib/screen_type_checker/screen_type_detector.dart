import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'not_allowed_view.dart';

class DeviceChecker extends StatelessWidget {
  final Widget child;
  final Widget notAllowedView;
  const DeviceChecker({
    Key key,
    @required this.child,
    this.notAllowedView = const NotAllowedView(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      initialData: true,
      future: _checkDevice(size),
      builder: (context, snapshot) {
        if (snapshot.data) {
          return child;
        } else {
          return notAllowedView;
        }
      },
    );
  }

  Future<bool> _checkDevice(Size size) async {
    double screenWith = 700;

    if (UniversalPlatform.isWeb &&
        UniversalPlatform.isWindows &&
        UniversalPlatform.isMacOS &&
        UniversalPlatform.isFuchsia &&
        UniversalPlatform.isLinux) {
      return false;
    }

    final isPhysicalDevice = await _isPhysicalDevice();

    if (isPhysicalDevice) {
      if (size.width >= screenWith) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _isPhysicalDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    bool isPhysicalDevice = androidInfo.isPhysicalDevice;

    print('isPhysical Device => $isPhysicalDevice');
    return isPhysicalDevice;
  }
}
