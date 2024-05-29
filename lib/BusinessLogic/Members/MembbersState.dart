import 'package:equatable/equatable.dart';
import 'package:starsport/Models/Member.dart';

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoaded extends MemberState {
  final List<Member> members;

  const MemberLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class MemberError extends MemberState {
  final String errorMessage;

  const MemberError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}