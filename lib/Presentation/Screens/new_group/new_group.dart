import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/Members/MembbersState.dart';
import 'package:starsport/BusinessLogic/Members/MembersCubit.dart';
import 'package:starsport/BusinessLogic/student_detail/StudentDetailCubit.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Models/student_detail.dart';
import 'package:starsport/Presentation/Screens/new_group/Component/Component.dart';


String new_name="";
class new_group extends StatefulWidget {
  final Group group;
  const new_group({super.key,required this.group});

  @override
  State<new_group> createState() => _new_groupState();
}

class _new_groupState extends State<new_group> {
@override
  void initState() {
    // TODO: implement initState
  BlocProvider.of<MemberCubit>(context).loadMembers(widget.group.id);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        centerTitle: true,
        actions: [
        IconButton(onPressed: (){
          Navigator.pop(context);


        }, icon: Icon(Icons.done))
      ],),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
      await _showMyDialog_add(context,widget.group.id);
      


      },child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child :BlocBuilder<MemberCubit, MemberState>(

            builder: (context, state) {
              if (state is MemberInitial) {
                return CircularProgressIndicator();
              } else if (state is MemberLoaded) {
                final members = state.members;
                // Build your UI with the loaded groups
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return GestureDetector(

                        child: C_newgroup_student(member,context));
                  },
                );
              } else if (state is MemberError) {
                return Text('Error: ${state.errorMessage}');
              } else {
                return Text('Unknown state');
              }
            },
          )
        ),
      ),
    );
  }
}
Future<void> _showMyDialog_add(BuildContext context,int groupId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      TextEditingController name=TextEditingController();
      TextEditingController grade=TextEditingController();
      TextEditingController phoneNumber=TextEditingController();
      TextEditingController parent=TextEditingController();
      return AlertDialog(
        title: const Text('Add New member'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Name:'),
              SizedBox(height: 10,),
              TextField(
                controller:name ,
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

              ),

              SizedBox(height: 10,),
                  Text('Parent :'),
              SizedBox(height: 10,),
              TextField(
                controller:parent ,
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

              ),

              SizedBox(height: 10,),
                  Text('phone number:'),
              SizedBox(height: 10,),
              TextField(
                controller:phoneNumber ,
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

              ),

              SizedBox(height: 10,),
                  Text('grad :'),
              SizedBox(height: 10,),
              TextField(
                controller:grade ,
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

              ),

              SizedBox(height: 10,),

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
            onPressed: () async{
              int id = await BlocProvider.of<MemberCubit>(context).addMember(groupId, name.text);
            StudentDetail student=StudentDetail(id: id, phoneNumber: int.parse(phoneNumber.text), name: name.text, parentName: parent.text, grade: grade.text);
              BlocProvider.of<StudentDetailsCubit>(context).addStudentDetail(student);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

}