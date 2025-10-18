import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';
import 'dart:convert'; // Import لازم يكون موجود عشان jsonEncode

class UpdateProductService {
  Future<ProductModel> updateProduct({
    required int id, // النوع int لـID المنتج
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    print('I/Service: Preparing PUT call for Product ID: $id'); // رسالة تتبع

    // تشفير الـMap لـJSON String
    String requestBody = jsonEncode({
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    });

    // ✅ إضافة try-catch لـService عشان أي Network Error يظهر بوضوح
    try {
      Map<String, dynamic> data = await Api().put(
        url: 'https://fakestoreapi.com/products/$id',
        body: requestBody, // إرسال الـbody كـJSON String
      );

      print(
        'I/Service: PUT call successful. Status: ${data['status']}',
      ); // تأكيد نجاح الـPUT

      // الـFake Store API بترجع Product Model سليم بعد الـPUT
      return ProductModel.fromJson(data);
    } catch (e) {
      // لو الـPUT فشلت لأي سبب (Network, Timeout, إلخ)
      print('E/Service: PUT request failed: ${e.toString()}');
      // مهم جداً نرمي (throw) الـException ده عشان الـUpdateProductScreen يمسكه ويعرض رسالة الفشل
      throw Exception(
        'Failed to update product due to network or server error: ${e.toString()}',
      );
    }
  }
}
