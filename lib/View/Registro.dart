import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto/crypto.dart';
import 'package:login_ganamax/DTO/User.dart';

class Registro extends StatefulWidget{
  final User cadena;
  Registro(this.cadena);
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<Registro>{
  bool _password = false;

  TextEditingController nombre = TextEditingController();
  TextEditingController identificacion = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  // metodo de conexion base de datos
  //asincrona se ejecuta dependiendo la necesidad que exista

  insertarDatos() async{
    try{
      String hashedPassword = sha256.convert(utf8.encode(password.text)).toString();
      await firebase.collection('Usuarios').doc().set({
        "NombreUsuario": nombre.text,
        "IndentidadUsuario": identificacion.text,
        "EmailUsuario": email.text,
        "passwordUsuario":hashedPassword,
        "Rol":'Invitado',
        "Estado":true,
      });
      print ('Datos guardados');
      mensaje('Información', 'Registro correcto');
    }catch(e){
      mensaje('Información', 'Registro incorrecto o error en el registro');
      print('error en insert...........' + e.toString());
    }
  }
  void mensaje(String titulo, String contenido){
      showDialog(context: context, builder: (buildcontext){
        return AlertDialog(
          title: Text(titulo),
          content: Text(contenido),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Aceptar', style: TextStyle(color: Colors.blueGrey),),
            )
          ],);
      });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios  ------>' +widget.cadena.nombre),
        backgroundColor: Color(0xED00FF3C),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
                  Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                    controller: nombre,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xED83C936)
                    ),
                  ),
              ),

              Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                    controller: identificacion,
                    decoration: InputDecoration(
                      labelText: 'Identificacion',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xED83C936)
                    ),
                  ),
              ),

              Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xED83C936)
                    ),
                  ),
              ),

              Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                    obscureText: _password,
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(_password ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _password = !_password;
                              });
                            }
                        )
                    ),
                    style: TextStyle(
                      color: Color(0xED83C936)
                    ),
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Registro()));                  print('botón presionado');
                      //print(nombre.text);
                      insertarDatos();
                      nombre.clear();
                      identificacion.clear();
                      email.clear();
                      password.clear();
                    },
                    child: Text('Registrar'),
                ),
               ),
            ]
        ),
      ),
    );

  }
}