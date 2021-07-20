import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    print('I am here');
    _controller.clear();
  }

  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 12),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.06,
            width: MediaQuery.of(context).size.width*0.8,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                labelText: 'Type a message',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.03,
          ),
          CircleAvatar( 
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
