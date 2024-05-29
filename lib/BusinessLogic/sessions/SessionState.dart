import 'package:equatable/equatable.dart';
import 'package:starsport/Models/Session.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {}

class SessionsLoaded extends SessionState {
  final List<Session> sessions;

  const SessionsLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

class SessionsError extends SessionState {
  final String errorMessage;

  const SessionsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}