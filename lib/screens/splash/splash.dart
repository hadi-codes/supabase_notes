import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 60,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
