import 'package:flutter/material.dart';

class MedicalRequestForm extends StatelessWidget {
  const MedicalRequestForm({Key key}) : super(key: key);

  static const routeName = '/medical-form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
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
                maxLines: 10,
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: InputBorder.none,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: () {},
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
