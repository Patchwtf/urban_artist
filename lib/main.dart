import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_artist/controller/authentication.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_artist/routes/feed.dart';
import 'package:urban_artist/routes/home.dart';
import 'package:urban_artist/src/widgets.dart';
import 'package:urban_artist/main.dart';
import 'firebase_options.dart';
import 'routes/lobby.dart';
import 'controller/controllerAuth.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Artist',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => Home(),
        'lobby': (context) => Lobby(),
        'Feed': (context) => Feed(),
      },
    );
  }
}
