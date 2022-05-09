import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_artist/controller/authentication.dart';
//import 'package:urbanartist/controllers/controllerAuth.dart';
import 'package:urban_artist/main.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:urban_artist/src/variables.dart';

import '../controller/controllerAuth.dart';

//

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(tituloPagina),
        ),
        body: ListView(
          children: <Widget>[
            Consumer<ApplicationState>(
              builder: (context, appState, _) => Authentication(
                email: appState.email,
                loginState: appState.loginState,
                startLoginFlow: appState.startLoginFlow,
                verifyEmail: appState.verifyEmail,
                signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
                cancelRegistration: appState.cancelRegistration,
                registerAccount: appState.registerAccount,
                signOut: appState.signOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class feedButton extends StatelessWidget {
  const feedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'Feed');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://i.gifer.com/IMXR.gif",
            ),
            Text(
              "Listo, Una vez que termines",
              style: TextStyle(
                fontSize: 80,
              ),
            ),
            Text(
              "Da Click Aqui",
              style: TextStyle(
                fontSize: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
