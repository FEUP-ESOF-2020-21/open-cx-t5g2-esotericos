import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BubbleNew extends StatefulWidget {
  @override
  _BubbleNew createState() => _BubbleNew();
}

class _BubbleNew extends State<BubbleNew> {
  TextEditingController controllerHeading = new TextEditingController();
  TextEditingController controllerText = new TextEditingController();

  CollectionReference bubblesCollection =
      FirebaseFirestore.instance.collection("Bubbles");

  int _value = 1;

  bool isAnonymous = false;

  void createBubble(String title, String text, bool isAnonymous, int value) {
    String user;
    if (isAnonymous) {
      user = 'anonymous';
    } else {
      user = FirebaseAuth.instance.currentUser.email;
    }
    bubblesCollection.add({
      'title': title,
      'text': text,
      'user': user,
      'category': value,
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'nLikes': 0,
      'nDislikes': 0,
      'nComments': 0,
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Text Field Error"),
      content: Text("Text Field must not be empty."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("NewBubblePage"),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add Bubble"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue.shade50, Colors.blue.shade600])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Category", style: TextStyle(fontSize: 30)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        key: Key("CategoriesDropdown"),
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child:
                                Text("Wishes", style: TextStyle(fontSize: 25)),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child:
                                Text("Risks", style: TextStyle(fontSize: 25)),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            key: Key("Appreciations"),
                            child: Text("Appreciations",
                                style: TextStyle(fontSize: 25)),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child:
                                Text("Puzzles", style: TextStyle(fontSize: 25)),
                            value: 4,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                  ),
                ),
                SizedBox(height: 20),
                CheckboxListTile(
                  key: Key("IsAnonymousField"),
                  title: Text("Anonymous Review: "),
                  value: isAnonymous,
                  onChanged: (newValue) {
                    setState(() {
                      isAnonymous = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: Key("TitleField"),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 2,
                  controller: controllerHeading,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the heading',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: Key("FeedbackTextField"),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  controller: controllerText,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your feedback',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      key: Key("NewBubbleButton"),
                      child: Text("Submit", style: TextStyle(fontSize: 25)),
                      onPressed: () {
                        if (controllerHeading.text.isEmpty) {
                          showAlertDialog(context);
                        } else {
                          createBubble(controllerHeading.text,
                              controllerText.text, isAnonymous, _value);
                          Navigator.pop(context);
                        }
                      },
                    ),
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
