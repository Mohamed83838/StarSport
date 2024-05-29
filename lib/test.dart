import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/groups/GroupState.dart';
import 'package:starsport/BusinessLogic/groups/groupCubit.dart';


class YourWidget extends StatefulWidget {
  @override
  State<YourWidget> createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupCubit()..loadGroups(),
      child: YourActualWidget(),
    );
  }
}

class YourActualWidget extends StatefulWidget {
  @override
  State<YourActualWidget> createState() => _YourActualWidgetState();
}

class _YourActualWidgetState extends State<YourActualWidget> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GroupCubit>(context).addGroup("hellokfhjddfh");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupInitial) {
          return CircularProgressIndicator();
        } else if (state is GroupsLoaded) {
          final groups = state.groups;
          // Build your UI with the loaded groups
          return Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: (){
              BlocProvider.of<GroupCubit>(context).addGroup("hellokfhjddfh");
            },),
            body: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return ListTile(
                  title: Text(group.name),
                  // Add more details or actions here
                );
              },
            ),
          );
        } else if (state is GroupsError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return Text('Unknown state');
        }
      },
    );
  }
}
