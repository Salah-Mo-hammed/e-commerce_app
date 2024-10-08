abstract class AuthState {
  final String? userId;
  final String? message;
  const AuthState({this.message, this.userId});
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateSuccess extends AuthState {
  AuthStateSuccess({required String id}) : super(userId: id);
}

class AuthStateException extends AuthState {
  final String? exceptionMessage;
  const AuthStateException({required this.exceptionMessage})
      : super(message: exceptionMessage);
}

class AuthStateLogOut extends AuthState {
  const AuthStateLogOut() : super(userId: null);
}
