import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallitac', votes: 4),
    Band(id: '2', name: 'Gouns roses', votes: 5),
    Band(id: '3', name: 'Suits', votes: 4),
    Band(id: '4', name: 'Toalla', votes: 3),
    Band(id: '5', name: 'Silla', votes: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Band Names',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            listbands(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addShowDialog();
        },
        child: Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget listbands(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete band',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addShowDialog() {
    final nameController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Banda nueva'),
              content: TextField(
                controller: nameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    addband(nameController.text);
                  },
                  child: Text('Add'),
                  color: Colors.blue,
                  elevation: 1,
                )
              ],
            );
          });
    } else if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('Banda nueva'),
              content: CupertinoTextField(
                controller: nameController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () {
                    addband(nameController.text);
                  },
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Exit'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  void addband(String name) {
    print(name);
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
