import 'package:flutter/material.dart';
import 'package:recipes_app_design/models/category_model.dart';
import 'package:recipes_app_design/models/meal_category_model.dart';
import 'package:recipes_app_design/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final _service = CategoryService();

  bool isLoading = false;
  List<CategoryModel> _categories = [];
  List<CategoryModel> getCategories() => _categories;

  Future<List<CategoryModel>> getAllCategories() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getCategories();
    _categories = response!;
    isLoading = false;
    notifyListeners();
    return _categories;
  }

  bool isMealLoading = false;
  List<MealCategoryModel> _meals = [];
  List<MealCategoryModel> getMeals() => _meals;

  Future<List<MealCategoryModel>> getMealsBasedOnCategories(
      {required String categoryName}) async {
    isMealLoading = true;
    notifyListeners();

    final response = await _service.getMealsBasedOnCategory(name: categoryName);
    _meals = response!;
    isMealLoading = false;
    notifyListeners();
    return _meals;
  }

  bool isSearchMealLoading = false;
  List<MealCategoryModel> _searchedMeals = [];
  List<MealCategoryModel> getSearchedMeals() => _meals;

  Future<List<MealCategoryModel>> searchMeal({required String text}) async {
    isSearchMealLoading = true;
    notifyListeners();

    final response = await _service.searchMeal(name: text);
    _searchedMeals = response!;
    isSearchMealLoading = false;
    notifyListeners();
    return _searchedMeals;
  }
}
