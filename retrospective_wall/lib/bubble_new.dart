import 'package:flutter/material.dart';
import 'feedback_text.dart';
import 'bubble.dart';

class BubbleNew extends StatefulWidget {

  @override
  _BubbleNew createState() => _BubbleNew();
}

class _BubbleNew extends State<BubbleNew> {

  TextEditingController controllerHeading = new TextEditingController();
  TextEditingController controllerText = new TextEditingController();

  int _value = 1;

  bool isAnonymous = false;

  Bubble createBubble(String title, String text, bool isAnonymous, int value) {
    return new Bubble(allBubbles.length + 1, title, isAnonymous, value, FeedbackText('Summary', text));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bubble"),
      ),
      body: Column(
        children: [
          Text("New Review:"),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.cyan,
              border: Border.all(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Wishes"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Risks"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Appreciations"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Puzzles"),
                      value: 4,
                    ),
                  ],
                  onChanged: (value) {
                    setState((){
                      _value = value;
                    });
                  }
              ),
            ),
          ),
          CheckboxListTile(
              title: Text("Anonymous Review: "),
              value: isAnonymous,
              onChanged: (newValue) {
                setState(() {
                  isAnonymous = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
          ),
          TextField(
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 2,
            controller: controllerHeading,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter the heading',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
            controller: controllerText,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your feedback',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Bubble b = createBubble(controllerHeading.text, controllerText.text, isAnonymous, _value);
                Navigator.pop(context, b);
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
