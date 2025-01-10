import 'dart:convert';

class MealCategoryModel {
  final String name;
  final String id;

  final String image;

  MealCategoryModel({
    required this.name,
    required this.id,
    required this.image,
  });

  factory MealCategoryModel.fromJson(Map<String, dynamic> json) {
    return MealCategoryModel(
      name: json['strMeal'],
      id: json['idMeal'],
      image: json['strMealThumb'],
    );
  }
}

List<MealCategoryModel> mealsFromJson(String str) {
  final json = jsonDecode(str)['meals'] as List;

  List<MealCategoryModel> categories = json.map((x) {
    return MealCategoryModel.fromJson(x);
  }).toList();

  return categories;
}
