import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  static const String _mockTokenKey = 'token';

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthEvent>(_handleCheckAuth);
    on<LoginRequested>(_handleLoginRequest);
    on<LogoutRequested>(_handleLogoutRequest);
  }

  Future<void> _handleCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final token = await _secureStore.read(key: _mockTokenKey);
    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _handleLoginRequest(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (event.email == 'test@test.com' && event.password == '1234') {
        await _secureStore.write(key: _mockTokenKey, value: 'mock_token');
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Invalid email or password'));
        emit(AuthUnauthenticated());
      }
    } catch (err) {
      emit(AuthError('Login failed: $err'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _handleLogoutRequest(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _secureStore.delete(key: _mockTokenKey);
    emit(AuthUnauthenticated());
  }
}
