import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/Members/MembersCubit.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailCubit.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailState.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Models/Member.dart';

class newSession extends StatefulWidget {
  final int session_id;
  final String session_name;
  final Group group;

  const newSession(
      {super.key,
      required this.session_id,
      required this.session_name,
      required this.group});

  @override
  State<newSession> createState() => _newSessionState();
}

class _newSessionState extends State<newSession> {
  @override
  @override
  List<Member> members = [];
  void initState() {
    // TODO: implement initState

    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await loadMembers();
    getMembers();
    await saveMembers();
    loadSessions();
  }

  Future<void> loadMembers() async {
    BlocProvider.of<MemberCubit>(context).loadMembers(widget.group.id);
  }

  Future<void> loadSessions() async {
    BlocProvider.of<SessionDetailCubit>(context)
        .loadSessionDetails(widget.session_id);
  }

  Future<void> saveMembers() async {
    List<Member> members =
        await BlocProvider.of<MemberCubit>(context).getmembers(widget.group.id);

    for (Member member in members) {
      print("hi");
      await BlocProvider.of<SessionDetailCubit>(context)
          .addSessionDetail(widget.session_id, 0, member.name);
    }
  }

  Future<void> getMembers() async {
    members =
        await BlocProvider.of<MemberCubit>(context).getmembers(widget.group.id);
    print(members.length);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session_name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.done))
        ],
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

                      return Container(
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
                            Checkbox(
                              checkColor: Colors.white,

                                value: sessiondetail.presence,
                                onChanged: (value) async {
                                  print(value.toString()+"  "+sessiondetail.presence.toString());
                                  int ch = 0;
                                  if (value != null) {
                                    ch = value ? 1 : 0;
                                  }
                                  await BlocProvider.of<SessionDetailCubit>(
                                          context)
                                      .updateSessionDetail(sessiondetail.id,widget.session_id,
                                          ch, sessiondetail.name);

                                  setState(() {}

                                  );
                                  print(sessiondetail.presence);
                                })
                          ],
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
