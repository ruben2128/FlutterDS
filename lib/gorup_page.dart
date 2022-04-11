// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Reuniones') , centerTitle: true, actions: [
          PopupMenuButton(color: Colors.blueAccent,itemBuilder: (context)=>[

            PopupMenuItem<int>(
              value: 0,
              child: Text("Ajustes de perfil", style: TextStyle(color: Colors.white)),
            ),

          ],)
        ]),
        body: StreamBuilder(
          stream: Firestore.instance.collection('reuniones').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;
            return ListView.separated(
              itemCount: docs.length,
              itemBuilder: (context, index){
                Map<String,dynamic>  data = docs[index].data;
                return ListTile(

                  title: Text(data['nombre']),
                  subtitle: Text(data['what']),
                );
              },
              separatorBuilder: (context, index){
                return Divider(
                  height: 1,
                  indent: 45,
                  endIndent: 15 ,
                );
              },
            );
          }
        ),
          floatingActionButton: SpeedDial(
          curve: Curves.easeOutExpo,
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black87,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          animatedIconTheme: IconThemeData.fallback(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.create_rounded),
                label: "Crear una reunión",
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white
            ),
            SpeedDialChild(
                child: Icon(Icons.group),
                label: "Unirse a una reunión",
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white
            )

          ]
      ),
      ),
    );
  }
}


