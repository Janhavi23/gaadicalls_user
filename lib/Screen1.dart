import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/settings.dart';
import 'package:flutterapp/vendor_details.dart';

import 'List.dart';
import 'db_helper.dart';


class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future <List<Vendor>> vendors;
  TextEditingController controller = TextEditingController();
  String name;
  int id;
  final formKey = new GlobalKey<FormState>();
  var dbhelper;
  bool isUpdating;

  _Screen1State() {
    dbhelper = DBhelper();
    isUpdating = false;
  }


  clearName() {
    controller.text = "";
  }



  add() {

        Vendor v = Vendor(controller.text, null);
        controller.text = "";
        dbhelper.save(v);
        setState(() {
        });
      
    
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              height: 50,
              color: Colors.transparent,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Vendor Name'
                ),
                controller: controller,
                style: TextStyle(fontSize: 20),
                validator: (val) =>
                    val.length == 0 ? 'Enter name of vendor' : null,
                onSaved: (val) => name = val,
              ),
            ),
                
              ],
            )
          
        ),
      );
    
  }

  data(List<Vendor> vendors) {
    return Column(
      children: vendors.map<Widget>((vendor)=>
      ListTile(
                title: Row(
                  children: <Widget>[
                   Text(vendor.vname)
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.settings), onPressed: () {
                        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()), );
                    }),
                    IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
                  ],
                ),
              )
        
        ).toList(),
        
    );
  }

  list() {
    return FutureBuilder(
        future: dbhelper.getVendor(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return data(snapshot.data);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Vendors List',
                style: TextStyle(
                  fontSize: 20,
                ))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            form(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
          add();
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Lists()));
          },
          label: Text(
            'ADD',
            style: TextStyle(fontSize: 15),
          ),
        ));
  }
}
