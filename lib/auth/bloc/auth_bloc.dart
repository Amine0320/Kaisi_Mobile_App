import 'package:bloc/bloc.dart';
import 'package:kaisi_app/auth/auth_provider.dart';
import 'package:kaisi_app/auth/bloc/auth_event.dart';
import 'package:kaisi_app/auth/bloc/auth_state.dart';

// This class represents the business logic component for handling authentication-related events
// and managing the state of authentication in the application.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Constructor for initializing the AuthBloc with an AuthProvider instance.
  AuthBloc(AuthProvider provider) : super(const AuthStateOnIntialized()) {
    // Event handler for user registration.
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification());
      } on Exception catch (e) {
        emit(AuthStateRegistering(e));
      }
    });

    // Event handler for initializing the authentication state.
    on<AuthEventIntialize>((event, emit) async {
      await provider.intialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    // Event handler for user login.
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(const AuthStateNeedsVerification());
        } else {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(AuthStateLoggedIn(user));
        }
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    // Event handler for user logout.
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });
  }
}
