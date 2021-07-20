import 'package:flutter/material.dart';

class NewFeedForm extends StatefulWidget {
  static const routeName = "/add-feed";
  @override
  _NewFeedFormState createState() => _NewFeedFormState();
}

class _NewFeedFormState extends State<NewFeedForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String password = "";

  void _submit() {
    // you can write your
    // own code according to
    // whatever you want to submit;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Feed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // this is where the
                    // input goes

                    TextFormField(
                      minLines: 4,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Icon(Icons.description),
                        ),
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        onPressed: _submit,
                        child: Text("submit"),
                      ),
                    ),
                  ],
                ),
              ),
              // this is where
              // the form field
              // are defined
            ],
          ),
        ),
      ),
    );
  }
}
