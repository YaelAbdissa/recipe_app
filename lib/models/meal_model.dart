// import 'dart:convert';

// class MealModel {
//   final String name;
//   final String id;
//   final String description;
//   final String image;

//   MealModel({
//     required this.name,
//     required this.id,
//     required this.description,
//     required this.image,
//   });

//   factory MealModel.fromJson(Map<String, dynamic> json) {
//     return MealModel(
//       name: json['strCategory'],
//       id: json['idCategory'],
//       description: json['strCategoryDescription'],
//       image: json['strCategoryThumb'],
//     );
//   }
// }

// List<MealModel> categoriesFromJson(String str) {
//   final json = jsonDecode(str)['categories'] as List;

//   List<MealModel> categories = json.map((x) {
//     return MealModel.fromJson(x);
//   }).toList();

//   return categories;
// }
