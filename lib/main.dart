import 'package:deeplink/page2.dart';
import 'package:deeplink/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Check if you received the link via `getInitialLink` first
  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink(); // Getx를 사용할 떄 컨트롤러의 INIT을 고려해야한다.

  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    print('${deepLink.query}');
    print('${deepLink.path}');
    print('test111');
    // Example of using the dynamic link to push the user to a different screen
    Navigator.pushNamed(Get.context!, deepLink.path);
  }

  FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) {
      // Set up the `onLink` event listener next as it may be received here
      if (pendingDynamicLinkData != null) {
        final Uri deepLink = pendingDynamicLinkData.link;
        print(deepLink.queryParameters['text']);
        print('${deepLink.path}');
        print('test333');
        // Example of using the dynamic link to push the user to a different screen
        Get.toNamed(deepLink.path, arguments: deepLink.queryParameters['text']);
      }
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      getPages:[
        GetPage(name: '/share', page: () => Deeppage())
      ]
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () async {
                  var link = await createDynamicLink('plzgoodresult');
                  Share.share(link.shortUrl.toString());
                  print('test');
                },
                child: Text('테스트')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<ShortDynamicLink> createDynamicLink(String text) async {
    return DynamiclinkService.instance.createDynamicLink(text);
  }
}
