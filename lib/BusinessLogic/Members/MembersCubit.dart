import 'package:bloc/bloc.dart';
import 'package:starsport/BusinessLogic/Members/MembbersState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';
import 'package:starsport/Models/Member.dart';




class MemberCubit extends Cubit<MemberState> {
  final sqflite _database =  sqflite();

  MemberCubit() : super(MemberInitial());

  void loadMembers(int groupId) async {
    try {
      final List<Member> members = await _database.getStudentsForGroup(groupId);
      emit(MemberLoaded(members.reversed.toList()));
    } catch (e) {
      emit(MemberError('Failed to load members: $e'));
    }
  }

  Future<int> addMember(int groupId,String name) async {
    try {


      int id =await _database.insertStudent(name,groupId);
      loadMembers(groupId); 
      return id;// Reload groups after adding a new one
    } catch (e) {
      emit(MemberError('Failed to add group: $e'));
      return 0;
    }
  }
Future<List<Member>>getmembers(int group_id)async{

    final List<Member> members = await _database.getStudentsForGroup(group_id);
   return members;

}
  void deleteMember(int memberId,int groupId) async {
    try {
      await _database.deleteStudent(memberId);
      loadMembers(groupId); // Reload groups after deleting one
    } catch (e) {
      emit(MemberError('Failed to delete group: $e'));
    }
  }
}