
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget{

  @override
  InicioApp createState() => InicioApp();
}

class InicioApp extends State<Inicio>{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('Usuarios');
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = _usersRef.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['NombreUsuario']),
                  subtitle: Text(data['EmailUsuario']),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
  }




