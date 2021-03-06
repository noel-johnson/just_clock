import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_clock/pages/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) =>
          GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just Clock',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic,
            splashFactory: InkSparkle.splashFactory,
            highlightColor: darkDynamic?.primaryContainer.withOpacity(0.2),
            splashColor: darkDynamic?.primaryContainer.withOpacity(0.2),
            scaffoldBackgroundColor: darkDynamic?.background),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic,
            splashFactory: InkSparkle.splashFactory,
            highlightColor: lightDynamic?.primaryContainer.withOpacity(0.2),
            splashColor: lightDynamic?.primaryContainer.withOpacity(0.3),
            scaffoldBackgroundColor: lightDynamic?.background),
        home: HomePage(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;
  const HomePage(
      {Key? key, required this.lightDynamic, required this.darkDynamic})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Center(child: Text("Alarm")),
      const Center(child: Text("Clock")),
      TimerPage(
          lightDynamic: widget.lightDynamic, darkDynamic: widget.darkDynamic),
      const Center(child: Text("Stopwatch")),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent.withOpacity(0.01),
            statusBarIconBrightness:
                Get.isDarkMode ? Brightness.light : Brightness.dark),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor:
                  widget.darkDynamic?.onSecondaryContainer.withOpacity(0.6)),
          child: NavigationBar(
            onDestinationSelected: (index) => {
              setState(
                () => {_currentIndex = index},
              )
            },
            selectedIndex: _currentIndex,
            destinations: [
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.alarm_rounded,
                    color: Get.isDarkMode
                        ? widget.darkDynamic?.background
                        : widget.lightDynamic?.onSurface,
                  ),
                  icon: Icon(Icons.alarm_rounded),
                  label: "Alarm"),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.schedule_rounded,
                    color: Get.isDarkMode
                        ? widget.darkDynamic?.background
                        : widget.lightDynamic?.onSurface,
                  ),
                  icon: Icon(Icons.schedule_rounded),
                  label: "Clock"),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.hourglass_bottom_rounded,
                    color: Get.isDarkMode
                        ? widget.darkDynamic?.background
                        : widget.lightDynamic?.onSurface,
                  ),
                  icon: Icon(Icons.hourglass_bottom_rounded),
                  label: "Timer"),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.timer_outlined,
                    color: Get.isDarkMode
                        ? widget.darkDynamic?.background
                        : widget.lightDynamic?.onSurface,
                  ),
                  icon: Icon(Icons.timer_outlined),
                  label: "Stopwatch"),
            ],
          ),
        ),
      ),
    );
  }
}
