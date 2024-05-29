import 'package:flutter/material.dart';
import 'package:starsport/Presentation/Screens/EditGroup/Component/Component.dart';

class EditGroup_screen extends StatefulWidget {
  const EditGroup_screen({super.key});

  @override
  State<EditGroup_screen> createState() => _EditGroup_screenState();
}

class _EditGroup_screenState extends State<EditGroup_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          _showMyDialog_add(context);
        }, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text("Group A"),

      ),


      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.black,),
body: Container(
  padding: EdgeInsets.all(20),
  child: ListView(
    children: [
      C_edit_group()
    ],
  ),
),
    );
  }
}
Future<void> _showMyDialog_delete(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to delete this students'),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
Future<void> _showMyDialog_add(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Add new member to the group :'),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color:Colors.black,
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color:Colors.black,
                        width: 1.5,
                      )),
                ),

              )

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}