import 'package:advanced_guidance/advanced_guidance.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appBarKey = GlobalKey();
  final appBarLeadingKey = GlobalKey();
  final appBarTitleKey = GlobalKey();
  final appBarActionKey = GlobalKey();

  final textKey = GlobalKey();
  final fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: GuidanceLayout(
        highlights: [
          Highlight.rect(appBarKey),
          Highlight.circular(appBarLeadingKey),
          Highlight.rect(
            appBarTitleKey,
            radius: const Radius.circular(8.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          Highlight.circular(appBarActionKey),
          Highlight.rect(
            textKey,
            radius: const Radius.circular(8.0),
            padding: const EdgeInsets.all(12.0),
          ),
        ],
        pages: const [
          Center(child: Text('AppBar Widget')),
          Center(child: Text('AppBar Leading')),
          Center(child: Text('AppBar Title')),
          Center(child: Text('AppBar Actions')),
          Center(child: Text('Simple Text Widget')),
        ],
        onFinished: () {},
        child: Scaffold(
          appBar: AppBar(
            key: appBarKey,
            title: Text(
              'Plugin example app',
              key: appBarTitleKey,
            ),
            leading: BackButton(
              key: appBarLeadingKey,
            ),
            actions: [
              IconButton(
                key: appBarActionKey,
                onPressed: () {},
                icon: const Icon(Icons.add_alert),
              )
            ],
          ),
          body: Center(
            child: Text(
              'Running on',
              key: textKey,
            ),
          ),
        ),
      ),
    );
  }
}
