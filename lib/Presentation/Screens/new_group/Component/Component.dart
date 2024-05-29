import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/Members/MembersCubit.dart';
import 'package:starsport/Models/Member.dart';

Widget C_newgroup_student(Member member,BuildContext context){
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(15),
    height: 60,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(member.name,style: TextStyle(fontSize: 20),),
        IconButton(onPressed: (){
          BlocProvider.of<MemberCubit>(context).deleteMember(member.id, member.group_id);

        }, icon: Icon(Icons.delete))

      ],
    ),
  );
}