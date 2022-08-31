import 'package:flutter_modul_fe/models/cart_model/add_to_cart_model.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/providers/cart_provider/cart_provider.dart';

class CartRepository {
  CartRepository({CartProvider? bookProvider})
      : _apiProvider = bookProvider ?? CartProvider();

  final CartProvider _apiProvider;

  Future getListCartByUserId({required int userId}) async {
    final response = await _apiProvider.getListCartByUserId(userId: userId);

    if (response is GetCartListModelPack) {
      return response.data;
    } else {
      return response;
    }
  }

  Future addDataToCart({
    required AddBookToCartModel data,
  }) async {
    final response = await _apiProvider.addDataToCart(data: data);

    return response;
  }

  Future removeDataFromCart({
    required int userId,
    required int bookId,
  }) async {
    final response = await _apiProvider.removeDataFromCart(
      userId: userId,
      bookId: bookId,
    );

    return response;
  }
}
