import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/student_detail/StudentDetailState.dart';
import 'package:starsport/DataBase/sqflite/sqflite.dart';
import 'package:starsport/Models/student_detail.dart';

class StudentDetailsCubit extends Cubit<StudentDetailState> {
  final sqflite _database = sqflite();

  StudentDetailsCubit() : super(StudentDetailInitial());

  void loadStudentDetails() async {
    try {
      final List<StudentDetail> StudentDetails = await _database.getStudentsDetails();
      emit(StudentDetailsLoaded(StudentDetails));
    } catch (e) {
      emit(StudentDetailsError('Failed to load Student details: $e'));
    }
  }

   Future<void> updateStudentDetail(StudentDetail studentDetail) async {
    try {
      await _database.updateStudentDetail(studentDetail);
      // Reload Student details or perform any other necessary actions
      loadStudentDetails();
    } catch (e) {
      emit(StudentDetailsError('Failed to update Student detail: $e'));
    }
  }
  Future<void> addStudentDetail(StudentDetail studentDetail) async {
    try {
      await _database.addStudentDetail(studentDetail);
      loadStudentDetails(); // Reload Student details after adding a new one

    } catch (e) {
      emit(StudentDetailsError('Failed to add Student detail: $e'));
    }
  }

  void deleteStudentDetail(int StudentId) async {
    try {
      await _database.deleteStudentDetail(StudentId);
      loadStudentDetails(); // Reload Student details after deleting one
    } catch (e) {
      emit(StudentDetailsError('Failed to delete Student detail: $e'));
    }
  }
  
}