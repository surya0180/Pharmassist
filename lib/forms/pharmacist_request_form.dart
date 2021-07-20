import 'package:flutter/material.dart';

class PharmacistRequestForm extends StatelessWidget {
  const PharmacistRequestForm({Key key}) : super(key: key);

  static const routeName = '/pharmacist-form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacist form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height*0.08,
                child: Icon(Icons.how_to_reg_sharp, size: MediaQuery.of(context).size.height*0.1,),
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
