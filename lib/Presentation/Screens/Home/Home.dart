import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/groups/GroupState.dart';
import 'package:starsport/BusinessLogic/groups/groupCubit.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Presentation/Screens/Home/Component/Component.dart';
import 'package:starsport/Presentation/Screens/sessions/Sessions.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,onPressed: (){
_showMyDialog_add(context);
      },child: Icon(Icons.add,color: Colors.white,),),
    body: Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 30),
      child: Column(
        children: [
          Text("All Groupes Data",style: TextStyle(fontSize: 20),),

          Expanded(child: BlocBuilder<GroupCubit, GroupState>(

            builder: (context, state) {
              if (state is GroupInitial) {
                return CircularProgressIndicator();
              } else if (state is GroupsLoaded) {
                final groups = state.groups;
                // Build your UI with the loaded groups
                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Sessions_screen(group: group,)),
                        );

                      },
                        onLongPress: (){
                          Show_Menue(context,group);
                        },
                        child: C_group(group.name));
                  },
                );
              } else if (state is GroupsError) {
                return Text('Error: ${state.errorMessage}');
              } else {
                return Text('Unknown state');
              }
            },
          ))


        ],
      ),
    ),
    
    );
  }
}
void Show_Menue(BuildContext context,Group group){
  showModalBottomSheet<void>(
    isDismissible: true,

      showDragHandle: true,
      context: context,
      builder: (BuildContext context_m) {
        return Menue(context_m,group);});
}


Future<void> _showMyDialog_add(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    
    builder: (BuildContext context) {
      TextEditingController name=TextEditingController();
      return AlertDialog(
        title: const Text('Add'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Add new group :'),
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
              BlocProvider.of<GroupCubit>(context).addGroup(name.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}