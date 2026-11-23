import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const HydraTrackApp());
}

class HydraTrackApp extends StatelessWidget {
  const HydraTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HydraTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const Scaffold(body: Center(child: Text('HydraTrack'))),
    );
  }
}
