import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailCubit.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailState.dart';
import 'package:starsport/Models/Session.dart';


class Students_screen extends StatefulWidget {
  final Session session;
  const Students_screen({super.key,required this.session});

  @override
  State<Students_screen> createState() => _Students_screenState();
}

class _Students_screenState extends State<Students_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SessionDetailCubit>(context)
        .loadSessionDetails(widget.session.id);
  }
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back)),
  centerTitle: true,
  title: Text(widget.session.date,style: TextStyle(fontSize: 20),),
),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: BlocBuilder<SessionDetailCubit, SessionDetailState>(
              builder: (context, state) {
                if (state is SessionDetailInitial) {
                  return CircularProgressIndicator();
                } else if (state is SessionDetailsLoaded) {
                  final sessiondetails = state.sessionDetails;
                  // Build your UI with the loaded groups
                  return ListView.builder(
                    itemCount: sessiondetails.length,
                    itemBuilder: (context, index) {
                      final sessiondetail = sessiondetails[index];

                      return GestureDetector(
                        onTap: (){
                          
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(15),
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sessiondetail.name,
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(sessiondetail.presence ? Icons.done :Icons.dangerous_sharp)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is SessionDetailsError) {
                  return Text('Error: ${state.errorMessage}');
                } else {
                  return Text('Unknown state');
                }
              },
            )),
      ),

    );
  }
}
