import 'package:flutter/material.dart';
import 'package:urban_artist/routes/lobby.dart';
import 'package:urban_artist/src/widgets.dart';
import 'package:urban_artist/src/variables.dart';
import 'package:urban_artist/controller/controllerAuth.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          title: Text("Bienvenidos"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: <Widget>[
            Expanded(
                child: Text(
              "Bienvenidos",
              style: TextStyle(
                  fontSize: 40, fontFamily: "KaushanScript-Regular.otf"),
              textAlign: TextAlign.center,
            )),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Utiliza esta plataforma para poder potenciarte y llevar tu rabajo al siguiente nivel sintiendote libre de trabajar a tu manera",
                    style: stilo,
                  ),
                  const FadeInImage(
                    placeholder: AssetImage("images/jar-loading.gif"),
                    image: AssetImage(
                      "images/grafitti.jpg",
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                      "Puede conocer a mas gente que puede compartir tu manera de ver el mundo y expresarlo de una manera completamente nueva",
                      style: stilo),
                  const FadeInImage(
                    placeholder: AssetImage("images/jar-loading.gif"),
                    image: AssetImage("images/grafoInicio.jpg"),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                      "Puede conocer a mas gente que puede compartir tu manera de ver el mundo y expresarlo de una manera completamente nueva",
                      style: stilo),
                  const FadeInImage(
                    placeholder: AssetImage("images/jar-loading.gif"),
                    image: AssetImage("images/musicos.jpg"),
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: [Text("Aplicacionn Diseñada por Jhosbyn Daniel")],
                  ),
                  Column(
                    children: [Text("Derechos Reservados 2022")],
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Lobby()));
                    },
                    child: Row(
                      children: [Text("Iniciar Sesion"), Icon(Icons.login)],
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Lobby()));
                    },
                    child: Row(
                      children: [
                        Text("Registrarse"),
                        Icon(Icons.person_add_alt)
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
