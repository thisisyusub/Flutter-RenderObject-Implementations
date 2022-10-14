import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:render_object_implementations/gap/gap_example.dart';
import 'package:render_object_implementations/progress_bar/progress_example.dart';
import 'package:render_object_implementations/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            brightness: Brightness.dark,
          ),
        ),
        home: const RenderObjectsListPage(),
        routes: {
          Routes.gapExample: (_) => const GapExample(),
          Routes.progressExample: (_) => const ProgressExample(),
        });
  }
}

class Example {
  final String title;
  final String route;

  const Example({
    required this.title,
    required this.route,
  });
}

class RenderObjectsListPage extends StatefulWidget {
  const RenderObjectsListPage({Key? key}) : super(key: key);

  @override
  State<RenderObjectsListPage> createState() => _RenderObjectsListPageState();
}

class _RenderObjectsListPageState extends State<RenderObjectsListPage> {
  final _routes = const <String>[
    Routes.gapExample,
    Routes.progressExample,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examples'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final route = _routes[index];

          return Opacity(
            opacity: 0.3,
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(route);
              },
              title: Text(route),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            ),
          );
        },
        itemCount: _routes.length,
      ),
    );
  }
}
