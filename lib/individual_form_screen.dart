import 'package:flutter/material.dart';
import 'package:flutter_individual_table/data_helper.dart';
import 'package:flutter_individual_table/individual_list_screen.dart';
import 'package:flutter_individual_table/main.dart';


class IndividualFormScreen extends StatefulWidget {
  const IndividualFormScreen({super.key});

  @override
  State<IndividualFormScreen> createState() => _IndividualFormScreenState();
}

class _IndividualFormScreenState extends State<IndividualFormScreen> {
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _businessNameController = TextEditingController();
  var _dateOfBusinessController = TextEditingController();
  var _natureOfBusinessController = TextEditingController();
  var _panNumberController = TextEditingController();
  var _gstNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual Table Form',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'First Name',
                      hintText: 'Enter First Name'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Last Name',
                      hintText: 'Enter Last Name'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _businessNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Business Name',
                      hintText: 'Enter Business Name'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _dateOfBusinessController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Date of Business',
                      hintText: 'Enter Date Of Business'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _natureOfBusinessController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Nature Of Business',
                      hintText: 'Enter Nature Of Business'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _panNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Pan Number',
                      hintText: 'Enter Pan Number'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _gstNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Gst Number',
                      hintText: 'Enter Gst Number'),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('---------> Save Button Clicked');
                    _Save();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _Save() async {
    print('--------------> _Save');
    print('----------------> First Name: ${_firstNameController.text}');
    print('---------------> Last Name: ${_lastNameController.text}');
    print('-------------> Business Name: ${_businessNameController.text}');
    print('-------------> Date Of Business: ${_dateOfBusinessController.text}');
    print('-------------> Natur Of Business: ${ _natureOfBusinessController.text}');
    print('-------------> Pan Number: ${ _panNumberController.text}');
    print('------------->Gst Number: ${_gstNumberController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colfirstName:_firstNameController.text,
      DatabaseHelper.collastName:_lastNameController.text,
      DatabaseHelper.colbusinessName: _businessNameController.text,
      DatabaseHelper.coldateOfBusiness:_dateOfBusinessController.text,
      DatabaseHelper.colnatureOfBusiness: _natureOfBusinessController.text,
      DatabaseHelper.colpanNumber: _panNumberController.text,
      DatabaseHelper.colgstNumber: _gstNumberController.text,
    };

    final result = await dbHelper.insertIndividualDetailsTable
      (
        row, DatabaseHelper.individualDetailsTable);

    debugPrint('--------> Inserted Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }

    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndividualListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
