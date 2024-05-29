import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/sessions/SessionCubit.dart';

Widget C_session(String date,int sessionId,BuildContext context,int groupId){
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 10),
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date,style: TextStyle(fontSize: 20),),
        IconButton(onPressed: (){
          BlocProvider.of<SessionCubit>(context).deleteSession(sessionId, groupId);
        }, icon: Icon(Icons.delete))
      ],
    ),
  );
}