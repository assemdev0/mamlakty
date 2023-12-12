abstract class ProductDetailsStates {}

class ProductDetailsInitState extends ProductDetailsStates {}

class IncrementProductCounterState extends ProductDetailsStates {}

class DecrementProductCounterState extends ProductDetailsStates {}

class ProductDetailsLoadingState extends ProductDetailsStates {}

class ProductDetailsSuccessState extends ProductDetailsStates {}

class ProductDetailsErrorState extends ProductDetailsStates {}

class SimilarProductLoadingState extends ProductDetailsStates {}

class SimilarProductSuccessState extends ProductDetailsStates {}

class SimilarProductErrorState extends ProductDetailsStates {}

class AddToCartLoadingState extends ProductDetailsStates {}

class AddToCartSuccessState extends ProductDetailsStates {}

class AddToCartErrorState extends ProductDetailsStates {}

class AddToFavoritesLoadingState extends ProductDetailsStates {}

class AddToFavoritesSuccessState extends ProductDetailsStates {}

class AddToFavoritesErrorState extends ProductDetailsStates {}

class RemoveFromFavoritesLoadingState extends ProductDetailsStates {}

class RemoveFromFavoritesSuccessState extends ProductDetailsStates {}

class RemoveFromFavoritesErrorState extends ProductDetailsStates {}
