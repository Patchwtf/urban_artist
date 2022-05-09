import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:urban_artist/routes/feed.dart';
import 'package:urban_artist/routes/home.dart';
import 'package:urban_artist/src/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:urban_artist/src/widgets.dart';
import 'package:urban_artist/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:urban_artist/controller/authentication.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(uploadPhoto());
}

class uploadPhoto extends StatefulWidget {
  const uploadPhoto({Key? key}) : super(key: key);

  @override
  State<uploadPhoto> createState() => _uploadPhotoState();
}

class _uploadPhotoState extends State<uploadPhoto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Publicación',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseStorage storage = FirebaseStorage.instance;
//*Variabels de control
  late final String fileName;
  late final File imageFile;
  bool bandera = false;
  String descriptionInput = "";
//?Metodo seleccionar foto
  Future<void> _takePhoto(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      fileName = path.basename(pickedImage!.path);
      imageFile = File(pickedImage.path);
      setState(() {
        bandera = true;
      });
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

//?Metodo subir foto a bd
  Future<void> _savePhoto(
      String nameUser, String descriptionPhoto, String uid) async {
    try {
      // Uploading the selected image with some custom meta data
      await storage.ref(fileName).putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': nameUser,
            'description': descriptionPhoto,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'uid': uid
          }));

      // Refresh the UI
      setState(() {});
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

//*uploaded or deleted

  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

//*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicación'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      StyledButton(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Seleccionar desde Galeria'),
                                Icon(Icons.browse_gallery)
                              ]),
                          onPressed: () {
                            _takePhoto('gallery');
                          })
                    ],
                  ),
                  Column(
                    children: [
                      StyledButton(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Seleccionar desde Camara'),
                                Icon(Icons.camera)
                              ]),
                          onPressed: () {
                            _takePhoto('camera');
                          }),
                    ],
                  ),
                  if (bandera)
                    Expanded(child: Image.file(imageFile))
                  else
                    Image.asset("images/7IlP.gif"),
                  Text("Ingresa Una Descripción"),
                  TextField(
                    onChanged: (texto) {
                      descriptionInput = texto;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: StyledButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text("Cancelar"), Icon(Icons.cancel)],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Feed()));
                            }),
                      ),
                      Expanded(
                        child: StyledButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text("Enviar"), Icon(Icons.send)],
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.userChanges().listen(
                                (user) {
                                  if (user != null) {
                                    _savePhoto(user.displayName!,
                                        descriptionInput, user.uid);
                                  }
                                },
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Feed()));
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
