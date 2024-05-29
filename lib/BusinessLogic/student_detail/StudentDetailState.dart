import 'package:equatable/equatable.dart';
import 'package:starsport/Models/student_detail.dart';


abstract class StudentDetailState extends Equatable {
  const StudentDetailState();

  @override
  List<Object?> get props => [];
}

class StudentDetailInitial extends StudentDetailState {}

class StudentDetailsLoaded extends StudentDetailState {
  final List<StudentDetail> StudentDetails;

  const StudentDetailsLoaded(this.StudentDetails);

  @override
  List<Object?> get props => [StudentDetails];
}

class StudentDetailsError extends StudentDetailState {
  final String errorMessage;

  const StudentDetailsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}