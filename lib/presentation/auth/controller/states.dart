abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class ChangeVisibilityPasswordState extends AuthStates {}

class ChangeDropDownValueState extends AuthStates {}

class GetAreaLoadingState extends AuthStates {}

class GetAreaSuccessState extends AuthStates {}

class GetAreaErrorState extends AuthStates {}
