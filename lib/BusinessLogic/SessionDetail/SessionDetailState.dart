import 'package:equatable/equatable.dart';
import 'package:starsport/Models/session_data.dart';

class SessionDetailState extends Equatable {
  const SessionDetailState();

  @override
  List<Object?> get props => [];
}

class SessionDetailInitial extends SessionDetailState {}

class SessionDetailsLoaded extends SessionDetailState {
  final List<member_data> sessionDetails;

  const SessionDetailsLoaded(this.sessionDetails);

  @override
  List<Object?> get props => [sessionDetails];
}

class SessionDetailsError extends SessionDetailState {
  final String errorMessage;

  const SessionDetailsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}