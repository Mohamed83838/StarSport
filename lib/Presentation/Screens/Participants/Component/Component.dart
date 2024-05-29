import 'package:flutter/material.dart';

Widget C_participant(){
  return Container(
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
        Icon(Icons.present_to_all)
      ],
    ),
  );
}