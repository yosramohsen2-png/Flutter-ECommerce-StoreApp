class ProductModel {
  final int? id;
  final String? title;
  final double? price; // ✅ النوع لازم يكون double لاستقبال الأرقام العشرية
  final String? description;
  final String? image;
  final RatingModel? rating;
  final String? category;

  ProductModel({
    required this.rating,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      title: jsonData['title'],
      id: jsonData['id'],
      category: jsonData['category'],

      // ✅ تحويل السعر لـdouble وإمكانية استقبال null
      price: jsonData['price'] != null
          ? double.tryParse(jsonData['price'].toString())
          : null,

      description: jsonData['description'],
      image: jsonData['image'],

      // ✅ التأكد من أن الـrating ليس null قبل تحويله لـModel
      rating: jsonData['rating'] != null
          ? RatingModel.fromJson(jsonData['rating'])
          : null,
    );
  }
}

class RatingModel {
  final double rate; // ✅ النوع double هو الأنسب للتقييمات
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> jsonData) {
    return RatingModel(
      // ✅ التحويل الإجباري لـdouble لضمان عدم حدوث Type Mismatch
      rate: double.parse(jsonData['rate'].toString()),
      // ✅ التحويل الإجباري لـint
      count: int.parse(jsonData['count'].toString()),
    );
  }
}
