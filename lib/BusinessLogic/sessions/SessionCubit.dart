import 'package:bloc/bloc.dart';
import 'package:starsport/BusinessLogic/sessions/SessionState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';
import 'package:starsport/Models/Session.dart';



class SessionCubit extends Cubit<SessionState> {
  final sqflite _database =  sqflite();

  SessionCubit() : super(SessionInitial());

  void loadSessions(int groupId) async {
    try {
      final List<Session> sessions = await _database.getSessionsForGroup(groupId);
      emit(SessionsLoaded(sessions));
    } catch (e) {
      emit(SessionsError('Failed to load groups: $e'));
    }
  }

  Future<int> addSession(int groupId) async {
    try {
      DateTime now =  DateTime.now();
      String date=now.year.toString()+"/"+now.month.toString()+"/"+now.day.toString();
      int id =await _database.insertSession(groupId, date);
      loadSessions(groupId); // Re
      return id;// load groups after adding a new one
    } catch (e) {
      emit(SessionsError('Failed to add group: $e'));
    }
    return -1;
  }

  void deleteSession(int sessionId,int groupId) async {
    try {
      await _database.deleteSession(sessionId);
      loadSessions(groupId); // Reload groups after deleting one
    } catch (e) {
      emit(SessionsError('Failed to delete group: $e'));
    }
  }
}