import '../../components.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoadingEvent>(_onAuthLoading);
    on<AuthSuccessfulEvent>(_onAuthSuccessful);
    on<NotAuthenticatedEvent>(_onNotAuthenticated);
    on<AuthFailedEvent>(_onAuthFailed);
  }

  void _onAuthLoading(AuthLoadingEvent event, Emitter<AuthState> emit) async {
    emit(AthenticatingState());
  }

  void _onAuthSuccessful(
      AuthSuccessfulEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticatedState(user: event.user!));
  }

  void _onAuthFailed(AuthFailedEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticationFailedState(error: event.error));
  }

  void _onNotAuthenticated(
      NotAuthenticatedEvent event, Emitter<AuthState> emit) async {
    emit(UnauthenticatedState());
  }
}
