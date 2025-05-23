class AuthService {
  Future<bool> login(String email, String senha) async {
    await Future.delayed(Duration(seconds: 3));
    return email == 'login@gmail.com' && senha == '123456';
  }
}