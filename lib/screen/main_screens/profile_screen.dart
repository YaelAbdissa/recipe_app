import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../../models/meal_category_model.dart';
import '../../providers/category_provider.dart';
import '../../providers/user_provider.dart';
import '../../widget/rating_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isExpanded = false;
  int selectedCategoryIndex = 0;
  List<String> categories = ["Recipe", "Videos", "Tag"];
  List<MealCategoryModel> meals = [];

  @override
  void initState() {
    super.initState();
    searchMeal();
  }

  searchMeal() async {
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false)
          .searchMeal(text: "chicken")
          .then(
        (value) {
          if (!mounted) return;
          setState(() {
            meals = value;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        "https://st3.depositphotos.com/1007566/18719/v/450/depositphotos_187191934-stock-illustration-professional-chef-cartoon.jpg",
                        width: 99,
                        height: 99,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Recipe",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Followers",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2.5M",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Following",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "279",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  userProvider.currentUser.firstName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Chef",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Private Chef \nPassionate about food and life \nMastering flavors one dish at a time",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: isExpanded ? null : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => isExpanded = !isExpanded);
                  },
                  child: Text(
                    isExpanded ? "Less" : "More...",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff0d9776),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return customCategory(index);
                    },
                    itemCount: categories.length,
                  ),
                ),
                categoryProvider.isSearchMealLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            final meal = meals[index];
                            return MyRecipeWidget(meal: meal);
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget customCategory(index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 107,
        padding: EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.only(right: 25, bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
          categories[index],
          style: TextStyle(
            color: selectedCategoryIndex == index
                ? Colors.white
                : Color(0xff0d9776),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }
}

class MyRecipeWidget extends StatelessWidget {
  final MealCategoryModel meal;
  const MyRecipeWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              meal.image,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "By Chef John",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                      ),
                      SizedBox(width: 10),
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
                            color: Color(0xff0d9776),
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: RatingWidget(),
          )
        ],
      ),
    );
  }
}
