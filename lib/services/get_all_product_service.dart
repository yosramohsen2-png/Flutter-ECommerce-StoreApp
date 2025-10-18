import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class GetAllProductService {
  Future<List<ProductModel>> getAllProduct() async {
    // 1. استدعاء الـAPI
    List<dynamic> data = await Api().get(
      url: 'https://fakestoreapi.com/products',
    );

    // ✅ استخدام .map().toList() لضمان إنشاء نسخة جديدة وتحويلها لـProductModel
    List<ProductModel> productList = data.map((item) {
      // نضمن تحويل العنصر لـMap<String, dynamic> قبل الـParsing
      return ProductModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return productList;
  }
}
