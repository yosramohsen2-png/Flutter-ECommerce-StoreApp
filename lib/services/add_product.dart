import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class AddlProduct {
  Future<ProductModel> addProduct(
    String title,
    String price,
    String description,
    String image,
    String category,
  ) async {
    Map<String, dynamic> data = await Api().post(
      url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
    );
    return ProductModel.fromJson(data);
  }
}
