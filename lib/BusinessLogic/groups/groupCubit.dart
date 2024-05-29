import 'package:bloc/bloc.dart';

import 'package:starsport/BusinessLogic/groups/GroupState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';

import 'package:starsport/Models/Group.dart';



class GroupCubit extends Cubit<GroupState> {
  final sqflite _database =  sqflite();

  GroupCubit() : super(GroupInitial());

  void loadGroups() async {
    try {
      final List<Group> groups = await _database.getGroups();
      emit(GroupsLoaded(groups.reversed.toList()));
    } catch (e) {
      emit(GroupsError('Failed to load groups: $e'));
    }
  }


  void addGroup(String name) async {
    try {
      await _database.insertGroup(name);
      loadGroups(); // Reload groups after adding a new one
    } catch (e) {
      emit(GroupsError('Failed to add group: $e'));
    }
  }

  void deleteGroup(int groupId) async {
    try {
      await _database.deleteGroup(groupId);
      loadGroups(); // Reload groups after deleting one
    } catch (e) {
      emit(GroupsError('Failed to delete group: $e'));
    }
  }
}