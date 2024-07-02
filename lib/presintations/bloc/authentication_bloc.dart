import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy/data/authentication_remote_data_source.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRemoteDsImp remoteDs;

  AuthenticationBloc(this.remoteDs) : super(UnAuthorized()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        if (event is SignUpEvent) {
          emit(AuthLoding());
          await remoteDs.signUp(event.email, event.password);
          emit(Authorized());
        } else if (event is SignInEvent) {
          emit(AuthLoding());
          await remoteDs.signIn(event.email, event.password);
          emit(Authorized());
        } else if (event is SignInAnonEvent) {
          emit(AuthLoding());
          await remoteDs.signInAnon();
          emit(Authorized());
        } else if (event is SignOutEvent) {
          emit(AuthLoding());
          await remoteDs.signOut();
          emit(UnAuthorized());
        } else if (event is IsSignedInEvent) {
          emit(AuthLoding());
          bool isSignedIn = remoteDs.isSignedIn();
          emit(isSignedIn ? Authorized() : UnAuthorized());
        }
      } catch (e) {
        emit(AuthError(errorMessage: e.toString()));
      }
    });
  }
}
