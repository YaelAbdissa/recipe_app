import 'package:flutter/material.dart';
import 'package:recipes_app_design/models/category_model.dart';
import 'package:recipes_app_design/models/meal_category_model.dart';
import 'package:recipes_app_design/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final _service = CategoryService();

  bool isLoading = false;
  List<CategoryModel> _categories = [];
  List<CategoryModel> getCategories() => _categories;

  bool isMealLoading = false;
  List<MealCategoryModel> _meals = [];
  List<MealCategoryModel> getMeals() => _meals;

  Future<List<CategoryModel>> getAllCategories() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getCategories();
    _categories = response!;
    isLoading = false;
    notifyListeners();
    return _categories;
  }

  Future<List<MealCategoryModel>> getMealsBasedOnCategories(
      {required String categoryName}) async {
    isMealLoading = true;
    notifyListeners();

    final response = await _service.getMealsBasedonCategory(name: categoryName);
    _meals = response!;
    isMealLoading = false;
    notifyListeners();
    return _meals;
  }

  // void callBothMethods() {
  //   getAllCategories();
  //   getMealsBasedOnCategories(categoryName: "Beef");
  // }
}
