import 'package:flutter/material.dart';
import 'package:flutter_individual_table/data_helper.dart';
import 'package:flutter_individual_table/individual_details_table%20_model.dart';
import 'package:flutter_individual_table/individual_list_screen.dart';
import 'package:flutter_individual_table/main.dart';

class EditIndividualFormScreen extends StatefulWidget {
  const EditIndividualFormScreen({super.key});

  @override
  State<EditIndividualFormScreen> createState() =>
      _EditIndividualFormScreenState();
}

class _EditIndividualFormScreenState extends State<EditIndividualFormScreen> {
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _businessNameController = TextEditingController();
  var _dateOfBusinessController = TextEditingController();
  var _natureOfBusinessController = TextEditingController();
  var _panNumberController = TextEditingController();
  var _gstNumberController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedId = 0;

  @override
  Widget build(BuildContext context) {
    if (firstTimeFlag == false) {
      print('------------->once execute');

      firstTimeFlag = true;

      final IndividualTableDetail =
          ModalRoute.of(context)!.settings.arguments as IndividualTableModel;

      print('------------>Received Data');
      print(IndividualTableDetail.id);
      print(IndividualTableDetail.firstName);
      print(IndividualTableDetail.lastName);
      print(IndividualTableDetail.businessName);
      print(IndividualTableDetail.dateOfBusiness);
      print(IndividualTableDetail.natureOfBusiness);
      print(IndividualTableDetail.panNumber);
      print(IndividualTableDetail.gstNumber);

      _selectedId = IndividualTableDetail.id!;

      _firstNameController.text = IndividualTableDetail.firstName;
      _lastNameController.text = IndividualTableDetail.lastName;
      _businessNameController.text = IndividualTableDetail.businessName;
      _dateOfBusinessController.text = IndividualTableDetail.dateOfBusiness;
      _natureOfBusinessController.text = IndividualTableDetail.natureOfBusiness;
      _panNumberController.text = IndividualTableDetail.panNumber;
      _gstNumberController.text = IndividualTableDetail.gstNumber;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Individual Table Form'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Delete")),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                print('Delete option clicked');
                _deleteFormDialog(context);
              }
            },
          ),
        ],
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
                    print('---------> Update Button Clicked');
                    _Update();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  print('----------> Cancel Button Clicked');
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('-------------> Delete Button Clicked');
                  _delete();
                },
                child: const Text('Delete'),
              )
            ],
            title: const Text('Are you sure you want to delete this'),
          );
        });
  }

  void _Update() async {
    print('--------------> _Update');

    print('----------------> First Name: ${_firstNameController.text}');
    print('---------------> Last Name: ${_lastNameController.text}');
    print('-------------> Business Name: ${_businessNameController.text}');
    print('-------------> Date Of Business: ${_dateOfBusinessController.text}');
    print(
        '-------------> Natur Of Business: ${_natureOfBusinessController.text}');
    print('-------------> Pan Number: ${_panNumberController.text}');
    print('------------->Gst Number: ${_gstNumberController.text}');

    Map<String, dynamic> row = {

      DatabaseHelper.colId: _selectedId,

      DatabaseHelper.colfirstName: _firstNameController.text,
      DatabaseHelper.collastName: _lastNameController.text,
      DatabaseHelper.colbusinessName: _businessNameController.text,
      DatabaseHelper.coldateOfBusiness: _dateOfBusinessController.text,
      DatabaseHelper.colnatureOfBusiness: _natureOfBusinessController.text,
      DatabaseHelper.colpanNumber: _panNumberController.text,
      DatabaseHelper.colgstNumber: _gstNumberController.text,
    };

    final result = await dbHelper.updateIndividualDetailsTable(
        row, DatabaseHelper.individualDetailsTable);

    debugPrint('--------> Updated Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Updated');
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

  void _delete() async {
    print('---------> delete');
    final result = await dbHelper.deleteIndividualDetailsTable(
        _selectedId, DatabaseHelper.individualDetailsTable);

    debugPrint('---------------> Deleted Row Id:$result');

    if (result > 0) {
      _showSuccessSnackBar(context, 'Deleted.');
      Navigator.pop(context);
    }
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndividualListScreen()));
    });
  }
}
