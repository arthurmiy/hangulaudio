import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hangulaudio/features/base64.dart';
import 'package:hangulaudio/pages/CustomPage.dart';
import 'package:hangulaudio/pages/KeyBoardInput.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: simpleLocationBuilder,
    notFoundRedirectNamed: '/',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Learn Hangul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
      BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

final simpleLocationBuilder = RoutesLocationBuilder(
  routes: {
    '/': (context, state, data) => const BeamPage(
      key: ValueKey('main'),
      title: 'Learning Hangul',
      child: KeyBoardInput(),
    ),
    '/custom/:data': (context, state, data) {
      var data = state.pathParameters['data'] ?? '';
      if (data.isNotEmpty) {
        if (data.length % 4 > 0) {
          data += '=' * (4 - data.length % 4); // as suggested by Albert221
        }
        var dataDecrypt = decrypt(data).split(",");
        if (dataDecrypt.length>=2) {
          return BeamPage(
            key: ValueKey('custom${data ?? "d"}'),
            title: 'Learning Hangul',
            child: CustomPage(randomWord: dataDecrypt[0],randomWordTranslation: dataDecrypt[1]),
          );
        }
      }

      return const BeamPage(
        key: ValueKey('main-2'),
        title: 'Learning Hangul',
        child: KeyBoardInput(),
      );
    },


  },
);