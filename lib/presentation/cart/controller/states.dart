abstract class CartStates {}

class CartInitState extends CartStates {}

class IncrementProductCounterState extends CartStates {}

class DecrementProductCounterState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}

class CartErrorState extends CartStates {}

class EditCartLoadingState extends CartStates {}

class EditCartSuccessState extends CartStates {}

class EditCartErrorState extends CartStates {}


class CheckoutOrderLoadingState extends CartStates {}

class CheckoutOrderSuccessState extends CartStates {}

class CheckoutOrderErrorState extends CartStates {}
