import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class TimerPage extends StatelessWidget {
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;
  const TimerPage(
      {Key? key, required this.lightDynamic, required this.darkDynamic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: const Center(child: Text("Timer")),
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: Material(
          borderRadius: BorderRadius.circular(50),
          color: (isDarkMode ? darkDynamic?.primary : lightDynamic?.primary) ??
              Theme.of(context).primaryColor,
          child: InkWell(
              onTap: () => {},
              child: Icon(
                Icons.play_arrow_rounded,
                size: 25,
                color: (isDarkMode
                        ? darkDynamic?.background
                        : lightDynamic?.background) ??
                    Colors.white,
              )),
        ),
      ).clipOval(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
