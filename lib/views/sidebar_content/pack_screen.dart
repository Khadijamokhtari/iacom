import 'package:flutter/material.dart';
import 'package:QRScanner/models/pack.dart';
import 'package:QRScanner/services/pack_details_screen.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/services/pack-api.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:QRScanner/views/sidebar/sidebar_layout.dart';

class PackScreen extends StatelessWidget  with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: SideBarLayout(),
        appBar: homeAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            child: FutureBuilder(
              future: fetchPack(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        Pack pack = snapshot.data[index];
                        return Container(

                          margin: EdgeInsets.only(left: 20, right: 15, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2,2),
                                blurRadius: 5,
                                spreadRadius: 1.0,
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PackDetailsScreen(pack)),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),child: Image.network('https://iacomapps.fr/data/fr.iacom.apps/drawable/${pack.image_art}', height: 150, fit: BoxFit.cover, width: 310,),),
                                SizedBox(height: 5),
                                Container(child: Text('${pack.nom_art}', style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),),
                                SizedBox(height: 5),
                                Container(padding: new EdgeInsets.only(right: 5.0, left:5), child: Text('${pack.sous_titre}', style: TextStyle(fontSize: 10, fontFamily: "Champagne&LimousinesBold", color: Colors.black),),),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                        );
                      }
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}