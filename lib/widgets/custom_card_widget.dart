import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/update_product_screen.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          UpdateProductScreen.id,
          arguments: product,
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  color: const Color.fromARGB(
                    255,
                    215,
                    215,
                    215,
                  ).withOpacity(0.2),
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Card(
              clipBehavior: Clip.none,
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // ✅ استخدام اسم المنتج الحقيقي (ونتعامل مع الـnull)
                      product.title ?? 'No Title',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                      // عشان الاسم الطويل ميكسرش الـCard
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // ✅ استخدام السعر الحقيقي (مع التأكد من التحويل لـString)
                          r'$ '
                          '${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.favorite, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 190,
            child: Image.network(
              // ✅ استخدام رابط الصورة الحقيقي
              product.image ?? 'https://via.placeholder.com/150',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              // لو الصورة مظهرتش (عشان الـhttp):
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error_outline),
            ),
          ),
        ],
      ),
    );
  }
}
