import 'package:flutter/material.dart';
bool? check=false;
Widget C_newsession(CallbackAction action){
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
        Text("Mohammed Fraj",style: TextStyle(fontSize: 20),),
        Checkbox(value: check, onChanged: (value){
          check=value;

        })
      ],
    ),
  );
}