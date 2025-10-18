import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_formfield.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key});
  static String id = 'Update Product';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  // المتغيرات اللي هتستقبل القيم الجديدة من الـText Fields
  String? ProductName;
  String? Image;
  String? Description;
  String? Price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // استقبال الـProduct Model اللي جاي من الـNavigation
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                // 1. Product Name
                CustomTextField(
                  hintext: 'Product Name',
                  onChanged: (data) {
                    ProductName = data;
                    // ✅ رسالة تتبع للتأكد من تحديث المتغير
                    print('I/UI: ProductName updated to: $ProductName');
                  },
                ),
                const SizedBox(height: 10),
                // 2. Description
                CustomTextField(
                  hintext: 'Description',
                  onChanged: (data) {
                    Description = data;
                  },
                ),
                const SizedBox(height: 10),
                // 3. Price
                CustomTextField(
                  inputType: TextInputType.number,
                  hintext: 'Price',
                  onChanged: (data) {
                    Price = data;
                  },
                ),
                const SizedBox(height: 10),
                // 4. Image
                CustomTextField(
                  hintext: 'Image',
                  onChanged: (data) {
                    Image = data;
                  },
                ),
                const SizedBox(height: 50),
                // 5. Update Button
                CustomButton(
                  text: 'Update',
                  onTap: () async {
                    // ✅ رسالة تتبع للتأكد من تنفيذ الـonTap
                    print('I/UI: Update button tapped. Starting operation...');

                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await updateProduct(product);
                      print('I/flutter: Update successful!');
                      // Navigator.pop(context);
                    } catch (e) {
                      print('E/flutter: Update failed: ${e.toString()}');
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // الدالة اللي بتعمل الـUpdate Service
  Future<void> updateProduct(ProductModel product) async {
    // ✅ رسالة تتبع للتأكد من دخول الدالة دي
    print('I/UI: Entering updateProduct function. Sending data to Service...');

    // ملاحظة: لو هنا الـProductName لسه بـnull (لو مغيرتش الاسم)،
    // وكمان product.title هو كمان null (وده مفروض ميكونش كده)،
    // ده اللي ممكن يعمل fatal error.

    await UpdateProductService().updateProduct(
      id: product.id!,
      title: ProductName ?? product.title!,
      price: Price ?? product.price!.toString(),
      description: Description ?? product.description!,
      image: Image ?? product.image!,
      category: product.category!,
    );
  }
}
