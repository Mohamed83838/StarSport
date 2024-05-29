import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/sessions/SessionCubit.dart';
import 'package:starsport/BusinessLogic/sessions/SessionState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Models/Session.dart';
import 'package:starsport/Presentation/Screens/Participants/Students.dart';
import 'package:starsport/Presentation/Screens/newSession/newSession.dart';
import 'package:starsport/Presentation/Screens/sessions/Component/Component.dart';

class Sessions_screen extends StatefulWidget {
  final Group group;
  const Sessions_screen({super.key,required this.group});

  @override
  State<Sessions_screen> createState() => _Sessions_screenState();
}

class _Sessions_screenState extends State<Sessions_screen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SessionCubit>(context).loadSessions(widget.group.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(widget.group.name),

      ),

    
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        DateTime now =  DateTime.now();
        String date=now.year.toString()+"/"+now.month.toString()+"/"+now.day.toString();
        bool exist=false;
        List<Session> sessions=await sqflite().getSessionsForGroup(widget.group.id);
        for (var session in sessions){
          if(session.date==date){
            exist=true;
          }
        }
        if(!exist){
          int id=  await BlocProvider.of<SessionCubit>(context).addSession(widget.group.id);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  newSession(session_id: id, session_name: date, group: widget.group)),
          );
        }else{
          var message=SnackBar(content: Text("Session already exist"));
          ScaffoldMessenger.of(context).showSnackBar(message);
        }


      },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.black,),
    body: Container(
      padding: EdgeInsets.all(20),
      child: BlocBuilder<SessionCubit, SessionState>(
      
        builder: (context, state) {
          if (state is SessionInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SessionsLoaded) {
            final sessions = state.sessions;
            // Build your UI with the loaded groups
            return ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Students_screen(session: session,)),
                      );
      
                    },
      
                    child: C_session(session.date,session.id,context,session.group_id));
              },
            );
          } else if (state is SessionsError) {
            return Text('Error: ${state.errorMessage}');
          } else {
            return Text('Unknown state');
          }
        },
      ),
    )

    );
  }
}
