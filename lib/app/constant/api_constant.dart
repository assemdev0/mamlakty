class ApiConstant {
  static const String baseUrl = "https://mamlakty.lineerp.live/";
  static const String categoriesPath = "api/v1/category";
  static const String bannerPath = "api/v1/banner";
  static const String newProductPath = "api/v1/product";

  static String productInCategoryPath({required int id}) =>
      "api/v1/product/category/$id";

  static String productDetailsPath({required int id}) => "api/v1/product/$id";
  static const String registerUserPath = "api/v1/register";
  static const String loginUserPath = "api/v1/login";
  static const String addToCartPath = "api/v1/cart/add";
  static const String addToFavoritesPath = "api/v1/wishlist";
  static const String getFavoritesPath = "api/v1/wishlist";

  static String removeFromFavoritesPath({
    required int id,
  }) =>
      "api/v1/wishlist/$id";
  static const String getProfile = "api/v1/get_user";
  static const String getCart = "api/v1/cart";
  static const String editCart = "api/v1/cart/update";
  static const String checkoutPath = "api/v1/order";
  static const String ordersPath = "api/v1/user/orders";
  static const String editUserPath = "api/v1/update_user";
  static const String getAreaPath = "api/v1/delivery_cost";
  static const String searchInCategoryPath = "api/v1/product/search";
}
