import 'package:equatable/equatable.dart';
import 'package:starsport/Models/Group.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupState {}

class GroupsLoaded extends GroupState {
  final List<Group> groups;

  const GroupsLoaded(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupsError extends GroupState {
  final String errorMessage;

  const GroupsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}