import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/groups/groupCubit.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Presentation/Screens/new_group/new_group.dart';

Widget C_group(String name){
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    height: 50,
    width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.black)
  ),
    child: Center(
      child: Text(name,style: TextStyle(
        color: Colors.black
      ),),
    ),
  );
}

Widget Menue(BuildContext context,Group group){

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: double.infinity,
    child: Column(
      children: [

        GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new_group(group: group)),
              );
            },
            child: Text("Edit Members",style: TextStyle(fontSize: 15),)),
        Container(padding: EdgeInsets.symmetric(horizontal: 40),child: Divider()),
        SizedBox(height: 10,),
        GestureDetector(
            onTap: (){
              BlocProvider.of<GroupCubit>(context).deleteGroup(group.id);
              Navigator.pop(context);
            },
            child: Text("Delete",style: TextStyle(fontSize: 15),)),
        Container(padding: EdgeInsets.symmetric(horizontal: 40),child: Divider()),
        Expanded(child: SizedBox()),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel",style: TextStyle(color: Colors.white),),style:ElevatedButton.styleFrom(backgroundColor: Colors.black),)
      ],
    )
  );
}