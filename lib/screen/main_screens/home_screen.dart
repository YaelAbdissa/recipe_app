import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app_design/models/category_model.dart';
import 'package:recipes_app_design/models/meal_category_model.dart';
import 'package:recipes_app_design/providers/category_provider.dart';
import 'package:recipes_app_design/widget/rating_widget.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  final UserProvider userProvider;
  const HomeScreen({super.key, required this.userProvider});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<MealCategoryModel> meals = [];
  int selectedCategoryIndex = 0;
  UserModel user = UserModel(
    id: "",
    firstName: "",
    email: "",
  );

  @override
  void initState() {
    getUserData();
    getData();

    super.initState();
  }

  getUserData() {
    Provider.of<UserProvider>(context, listen: false)
        .getCurrentUser()
        .then((value) {
      print("object currentUser value ${value.firstName}");
      setState(() {
        user = value;
      });
      print("object currentUser user ${user.firstName}");
    });
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false)
          .getAllCategories()
          .then((value) {
        Provider.of<CategoryProvider>(context, listen: false)
            .getMealsBasedOnCategories(categoryName: "beef")
            .then((valueMeal) {
          if (!mounted) return;
          setState(() {
            categories = value;
            meals = valueMeal;
          });
        });
      });
    });
  }

  getMeals(categoryName) {
    Provider.of<CategoryProvider>(context, listen: false)
        .getMealsBasedOnCategories(categoryName: categoryName)
        .then((value) {
      setState(() {
        meals = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: categoryProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        homeHeaderWidget(),
                        SizedBox(height: 25),
                        searchBarWidget(context),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return customCategoryWidget(index);
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        categoryProvider.isMealLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                height: 235,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: meals.length,
                                  itemBuilder: (context, index) {
                                    MealCategoryModel meal = meals[index];
                                    return mealRecipeWidget(meal);
                                  },
                                ),
                              ),
                        SizedBox(height: 20),
                        // recipe of the day
                        recipeOfTheDay(),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget recipeOfTheDay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recipe of the Day",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff303030),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 127,
            child: Stack(
              children: [
                Positioned(
                  top: 25,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45, // Shadow color
                          spreadRadius: 0.5, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  "Teriyaki Chicken Casserole",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff484848),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: Color(0xffff9c00),
                                    size: 17,
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      "assets/person.jpeg",
                                      height: 33,
                                      width: 33,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "By James Milner",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffa9a9a9),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    IconsaxPlusLinear.timer_1,
                                    color: Color(0xffa9a9a9),
                                    size: 19,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "20 mins",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffa9a9a9),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45, // Shadow color
                          spreadRadius: 0.5, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.network(
                        "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mealRecipeWidget(MealCategoryModel meal) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 25),
      margin: EdgeInsets.symmetric(horizontal: 10),
      // color: Colors.amber,
      width: 160,
      child: Stack(
        children: [
          Positioned(
            top: 60,
            child: Container(
              height: 176,
              width: 160,
              decoration: BoxDecoration(
                  color: Color(0xffd9d9d9).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Positioned(
            left: 20,
            top: 5,
            // right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45, // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 10, // Blur radius
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.network(
                  meal.image,
                  height: 120,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: Text(
                      meal.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.clip,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xffa9a9a9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "15 Mins",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff303030),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconsaxPlusLinear.heart,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 35,
            child: RatingWidget(),
          )
        ],
      ),
    );
  }

  onCategoryPressed(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  Widget customCategoryWidget(int index) {
    return GestureDetector(
      onTap: () {
        onCategoryPressed(index);
        getMeals(categories[index].name);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              selectedCategoryIndex == index ? Color(0xff0d9776) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12, // Shadow color
              spreadRadius: 0.1, // Spread radius
              blurRadius: 4, // Blur radius
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
            child: Text(
          categories[index].name,
          style: TextStyle(
            color: selectedCategoryIndex == index
                ? Colors.white
                : Color(0xff0d9776),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }

  Widget searchBarWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/search");
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.76,
            child: TextField(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/search",
                  arguments: {
                    "searchText": "Burger",
                    "categories": categories,
                  },
                );
              },
              onSubmitted: (value) {
                Navigator.pushNamed(
                  context,
                  "/search",
                  arguments: {
                    "searchText": "Burger",
                    "categories": categories,
                  },
                );
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Search recipe",
                hintStyle: TextStyle(
                  color: Color(0xffd9d9d9),
                ),
                prefixIcon: Icon(
                  IconsaxPlusLinear.search_normal_1,
                  color: Color(0xffd9d9d9),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff0d9776),
          ),
          child: Icon(
            IconsaxPlusLinear.setting_4,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget homeHeaderWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello ${user.firstName}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "What are you cooking today?",
                style: TextStyle(
                  color: Color(0xff9e9e9e),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffffce80),
            ),
            child: Image.asset(
              "assets/avatar2.png",
            ),
          )
        ],
      ),
    );
  }
}
