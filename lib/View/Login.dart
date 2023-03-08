import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:login_ganamax/View/Inicio.dart';
import 'package:login_ganamax/main.dart';



class Login extends StatefulWidget{

  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login>{
  bool _password = false;

  TextEditingController nombre = TextEditingController();
  TextEditingController password = TextEditingController();

  validarDatos() async{
    try{
      String hashedPasswordUsuario = sha256.convert(utf8.encode(password.text)).toString();
        CollectionReference ref = FirebaseFirestore.instance.collection('Usuarios');
        QuerySnapshot usuario = await ref.get();

        if(usuario.docs.length !=0){
          //hace un recorrido por todos los documentos
          for(var cursor in usuario.docs){
              if(cursor.get("NombreUsuario")== nombre.text && cursor.get("passwordUsuario") == hashedPasswordUsuario){
                print('Acceso permitido');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio()));
              }else{
                //print('Usuario no encontrado');
                if(cursor.get("EmailUsuario")== nombre.text && cursor.get("passwordUsuario") == hashedPasswordUsuario){
                    print('Acceso permitido');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio()));
                }
              }
          }
        }else{
          print('no hay documentos en la colecion');
        }

    }catch(e){
      print('error en insert...........' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ingresar login'),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image(image: AssetImage('images/logo.png'),),
                  ),
                ),


                Padding(padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nombre,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nombre de Usuario',
                      hintText: 'Digite Nombre de Usuario',
                    ),
                  ),
                ),



                Padding(padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: _password,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:Icon(Icons.password),
                      labelText: 'password',
                      hintText: 'Digite password',
                        suffixIcon: IconButton(
                            icon: Icon(_password ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _password = !_password;
                              });
                            }
                        )
                      //obscureText: true,/* <-- Aquí */
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      print('botón presionado');
                      validarDatos();
                    },
                    child: Text('entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}