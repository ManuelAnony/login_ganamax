import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'View/Registro.dart';
import 'firebase_options.dart';
import 'View/Login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false , home: Home());
  }
}

class Home extends StatefulWidget {

  @override
    HomeStart createState() => HomeStart();

}

class HomeStart extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bienevenidos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Linea 2'),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  print('botón presionado');
                },
                child: Text('Entrar'),
              ),
            ),
              Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Registro()));
                  print('botón presionado');
                },
                child: Text('Registrar'),
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}

