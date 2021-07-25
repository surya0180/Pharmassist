import 'package:flutter/material.dart';

class MedicalRequestForm extends StatefulWidget {
  const MedicalRequestForm({Key key}) : super(key: key);

  static const routeName = '/medical-form';

  @override
  _MedicalRequestFormState createState() => _MedicalRequestFormState();
}

class _MedicalRequestFormState extends State<MedicalRequestForm> {
  final _form = GlobalKey<FormState>();

  String _title;
  String _request;

  void _saveForm() {
    _form.currentState.save();
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
    print(_title);
    print(_request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height*0.08,
                child: Icon(Icons.medical_services, size: MediaQuery.of(context).size.height*0.1,),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                'Title  :',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value)  {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                'Request details  :',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: InputBorder.none,
                ),
                textInputAction: TextInputAction.none,
                onSaved: (value) {
                  setState(() {
                    _request = value;
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(
                  'Send request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
