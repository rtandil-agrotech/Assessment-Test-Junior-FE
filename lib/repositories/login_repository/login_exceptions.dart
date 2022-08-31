class LoginFailed implements Exception {}

class WrongEmailLoginFailed extends LoginFailed {}

class WrongPasswordLoginFailed extends LoginFailed {}
