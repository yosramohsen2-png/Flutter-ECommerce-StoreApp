import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_product_service.dart';
import 'package:store_app/widgets/custom_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.cartPlus, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('New Trend', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 85),
        child: FutureBuilder<List<ProductModel>>(
          future: GetAllProductService().getAllProduct(),
          builder: (context, snapshot) {
            // 1. حالة النجاح: لو الداتا وصلت خلاص
            if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;

              return GridView.builder(
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  crossAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  // متأكدين إن الداتا بتتبعت للـCustomCardWidget
                  return CustomCardWidget(product: products[index]);
                },
              );

              // 2. حالة الخطأ: لو حصل استثناء أثناء جلب البيانات (ده اللي هيحل المشكلة)
            } else if (snapshot.hasError) {
              // بنعرض رسالة الخطأ اللي جات من الـApi class
              return Center(
                child: Text(
                  'Error: ${snapshot.error.toString()}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );

              // 3. حالة الـLoading: لو لسه بيحاول يجيب الداتا
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
