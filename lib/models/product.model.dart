import 'package:shopify/models/category.model.dart';

class Product {
  String? id;
  String? name;
  double? price;
  String? description;
  String? image;
   CategoryData? category;
  // Map<String, dynamic>? categoryMap;
  String? categoryId;
  String? subCategoryId;


  String? brand;
  String? condition;
  String? sku;
  String? material;
  String? fitting;
  int? quantity;
  DateTime? createdAt;
  Map<String, List<dynamic>>? variants;

  Product();

  Product.fromJson(Map<String, dynamic> data, [String? docId]) {
    id = docId;
    name = data['name'];
    price = data['price'] is int
        ? (data['price'] as int).toDouble()
        : data['price'];
    image = data['image'];
    description = data['description'];
    categoryId= data['categoryId'];
    subCategoryId= data['subCategoryId'];

    // categoryMap = (Map<String, dynamic>.from(data['category']));
    // categoryId = categoryMap!.entries.first.value;

    category = data['category'] != null
        ? CategoryData.fromJson(data['category'], categoryId)
        : null;
    
    brand = data['brand'];
    condition = data['condition'];
    sku = data['sku'];
    material = data['material'];
    fitting = data['fitting'];
    quantity = data['quantity'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        data['createdAt'].millisecondsSinceEpoch);
    variants = Map<String, List<dynamic>>.from(data['variants']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "image": image,
      "description": description,
      "category": category?.toJson(),
      "brand": brand,
      "condition": condition,
      "sku": sku,
      "material": material,
      "fitting": fitting,
      "quantity": quantity,
      "createdAt": createdAt,
      "variants": variants,
      "subCategoryId":subCategoryId,
    };
  }
}
