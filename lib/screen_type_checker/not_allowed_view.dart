import 'package:flutter/material.dart';

class NotAllowedView extends StatelessWidget {
  const NotAllowedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Text(
        'Device Not Allowed',
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
