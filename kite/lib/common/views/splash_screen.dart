import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Function? retryAction;

  const SplashScreen({super.key, this.retryAction});

  List<Widget> getWidgets(){
    final logo = Image.asset(
      'assets/kite.png',
      width: 80,
      fit: BoxFit.contain,
    );
    final spacing = 20.0;
    if (retryAction != null){
      return [
        Column(
          spacing: spacing,
          children: <Widget>[
            logo,
            const Text('An error occurred while fetching your news'),
            CupertinoButton(
              onPressed: () => retryAction?.call(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ];
    }else{
      return [
        Column(
          spacing: spacing,
          children: <Widget>[
            logo,
            const CircularProgressIndicator(),
          ],
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getWidgets(),
        ),
      ),
    );
  }
}
