import 'package:http/http.dart' as http;
import 'package:recipes_app_design/models/category_model.dart';
import 'package:recipes_app_design/models/meal_category_model.dart';

import '../constants/constants.dart';

class CategoryService {
  Future<List<CategoryModel>?> getCategories() async {
    String url = "${urlString}categories.php";

    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      return categoriesFromJson(responseBody);
    }
    return null;
  }

  Future<List<MealCategoryModel>?> getMealsBasedOnCategory(
      {required String name}) async {
    String url = "${urlString}filter.php?c=$name";

    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      return mealsFromJson(responseBody);
    }
    return null;
  }

  Future<List<MealCategoryModel>?> searchMeal({required String name}) async {
    String url = "${urlString}filter.php?c=$name";

    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      return mealsFromJson(responseBody);
    }
    return null;
  }
}
