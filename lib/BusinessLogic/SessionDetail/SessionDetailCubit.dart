import 'package:bloc/bloc.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';
import 'package:starsport/Models/session_data.dart';

class SessionDetailCubit extends Cubit<SessionDetailState> {
  final sqflite _database = sqflite();

  SessionDetailCubit() : super(SessionDetailInitial());

  void loadSessionDetails(int sessionId) async {
    try {
      final List<member_data> sessionDetails = await _database.get_session_details(sessionId);
      emit(SessionDetailsLoaded(sessionDetails));
    } catch (e) {
      emit(SessionDetailsError('Failed to load session details: $e'));
    }
  }
  Future<void> updateSessionDetail(int sessionDetailId,int sessionId, int presence, String name) async {
    try {
      await _database.updateSessionDetail(sessionDetailId, presence, name);
      // Reload session details or perform any other necessary actions
      loadSessionDetails(sessionId);
    } catch (e) {
      emit(SessionDetailsError('Failed to update session detail: $e'));
    }
  }
  Future<void> addSessionDetail(int sessionId, int presence, String name) async {
    try {
      await _database.insertSessionDetail(sessionId, presence, name);
      loadSessionDetails(sessionId); // Reload session details after adding a new one

    } catch (e) {
      emit(SessionDetailsError('Failed to add session detail: $e'));
    }
  }

  void deleteSessionDetail(int detailId, int sessionId) async {
    try {
      await _database.deleteSessionDetail(detailId);
      loadSessionDetails(sessionId); // Reload session details after deleting one
    } catch (e) {
      emit(SessionDetailsError('Failed to delete session detail: $e'));
    }
  }
}