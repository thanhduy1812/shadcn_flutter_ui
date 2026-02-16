import 'package:flutter/services.dart';
import 'package:flutter/material.dart' as material show Colors;
import 'package:vnl_common_ui/shadcn_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: material.Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLookApp(
      title: 'My App',
      home: const CounterPage(),
      theme: ThemeData(
        colorScheme: LegacyColorSchemes.darkZinc(),
        radius: 0.7,
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  CounterPageState createState() => CounterPageState();
}

class CounterPageState extends State<CounterPage> {
  int _counter = 0;

  Key? _selected = const ValueKey(0);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  VNLNavigationItem _buildButton(String label, IconData icon, Key key) {
    return VNLNavigationItem(
      key: key,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: const Text('Counter App'),
          subtitle: const Text('A simple counter app'),
          leading: [
            VNLGhostButton(
              onPressed: () {
                openDrawer(
                  context: context,
                  builder: (context) {
                    return Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: const Text('Drawer'),
                    );
                  },
                  position: OverlayPosition.left,
                );
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.menu),
            ),
          ],
          trailing: [
            VNLGhostButton(
              density: ButtonDensity.icon,
              onPressed: () {
                openSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                      ),
                      child: const Text('Sheet'),
                    );
                  },
                  position: OverlayPosition.right,
                );
              },
              child: const Icon(Icons.search),
            ),
          ],
        ),
        const VNLDivider(),
      ],
      footers: [
        const VNLDivider(),
        VNLNavigationBar(
          onSelected: (key) {
            setState(() {
              _selected = key;
            });
          },
          selectedKey: _selected,
          children: [
            _buildButton('Home', Icons.home, const ValueKey(0)),
            _buildButton('Explore', Icons.explore, const ValueKey(1)),
            _buildButton('Library', Icons.library_music, const ValueKey(2)),
          ],
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
                textAlign: TextAlign.center,
              ).p(),
              Text(
                '$_counter',
              ).h1(),
              PrimaryButton(
                onPressed: _incrementCounter,
                density: ButtonDensity.icon,
                child: const Icon(Icons.add),
              ).p(),
            ],
          ),
        ),
      ),
    );
  }
}
