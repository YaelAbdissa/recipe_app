import 'dart:convert';

class CategoryModel {
  final String name;
  final String id;
  final String description;
  final String image;

  CategoryModel({
    required this.name,
    required this.id,
    required this.description,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['strCategory'],
      id: json['idCategory'],
      description: json['strCategoryDescription'],
      image: json['strCategoryThumb'],
    );
  }
}

List<CategoryModel> categoriesFromJson(String str) {
  final json = jsonDecode(str)['categories'] as List;

  List<CategoryModel> categories = json.map((x) {
    return CategoryModel.fromJson(x);
  }).toList();

  return categories;
}
