import 'package:flutter/material.dart';
import 'package:flutter_individual_table/main.dart';
import 'package:flutter_individual_table/optimized_individual_form_screen.dart';
import 'data_helper.dart';
import 'individual_details_table _model.dart';


class IndividualListScreen extends StatefulWidget {
  const IndividualListScreen({super.key});

  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {

  late List<IndividualTableModel> _IndividualDetailList = <IndividualTableModel>[];

  @override
  void initState() {
    super.initState();
    getAllIndividualDetailsTable();
  }

  getAllIndividualDetailsTable() async {


    var individualDetailsTableRecords =
    await dbHelper.queryAllRows(DatabaseHelper.individualDetailsTable);

    individualDetailsTableRecords.forEach((individualDetail) {

      setState(() {

        print(individualDetail['_id']);
        print(individualDetail['_firstName']);
        print(individualDetail['_lastName']);
        print(individualDetail['_businessName']);
        print(individualDetail['_dateOfBusiness']);
        print(individualDetail['_natureOfBusiness']);
        print(individualDetail['_panNumber']);
        print(individualDetail['_gstNumber']);

        var individualTableModel = IndividualTableModel(
            individualDetail['_id'],
            individualDetail['_firstName'],
            individualDetail['_lastName'],
            individualDetail['_businessName'],
            individualDetail['_dateOfBusiness'],
            individualDetail['_natureOfBusiness'],
            individualDetail['_panNumber'],
            individualDetail['_gstNumber']);

        _IndividualDetailList.add(individualTableModel);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual Table Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: _IndividualDetailList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Delete Invoked: send Data');

                  print( _IndividualDetailList[index].id);
                  print( _IndividualDetailList[index].firstName);
                  print( _IndividualDetailList[index].lastName);
                  print( _IndividualDetailList[index].businessName);
                  print( _IndividualDetailList[index].dateOfBusiness);
                  print( _IndividualDetailList[index].natureOfBusiness);
                  print( _IndividualDetailList[index].gstNumber);


                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OptimizedIndividualFormScreen(),
                    settings: RouteSettings(
                      arguments:_IndividualDetailList[index],
                    ),
                  ));
                },
                child: ListTile(
                  title: Text(_IndividualDetailList[index].firstName),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('-----> Launch Individual Details Form Screen');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OptimizedIndividualFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
