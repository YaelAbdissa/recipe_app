import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:recipes_app_design/models/category_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedTimeIndex = 0;
  int selectedCategoryIndex = 0;
  List<String> timeCategory = [
    "All",
    "Newest",
    "Oldest",
    "Popularity",
  ];
  List<CategoryModel> categoryList = [];
  List<String> rateCategory = ["5", "4", "3", "2", "1"];
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    categoryList = data["categories"];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconsaxPlusLinear.arrow_left),
                  SizedBox(
                    width: 60,
                  ),
                  Expanded(
                    child: Text(
                      "Search recipes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              searchBarWidget(context),
              SizedBox(height: 15),
              Text(
                "Search Result",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(child: Text("blah")),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBarWidget(context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
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
            onSubmitted: (val) {},
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                builder: (builder) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Filter Search",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: timeCategory.length,
                              itemBuilder: (context, index) {
                                return customTimeCategory(
                                  index,
                                  timeCategory,
                                  selectedTimeIndex,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: rateCategory.length,
                              itemBuilder: (context, index) {
                                return customRateCategory(
                                  index,
                                  rateCategory,
                                  selectedTimeIndex,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Wrap(
                              spacing: 5.0, // Horizontal spacing between chips
                              // runSpacing: 2.0,
                              children:
                                  List.generate(categoryList.length, (index) {
                                return customCategory(index);
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
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
          ),
        )
      ],
    );
  }

  Widget customTimeCategory(index, List listItem, selectedIndex) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right: 8, top: 3, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Color(0xff0d9776),
        ),
        color: selectedIndex == index ? Color(0xff0d9776) : Colors.white,
      ),
      child: Center(
        child: Text(
          listItem[index],
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : Color(0xff0d9776),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget customRateCategory(index, List listItem, selectedIndex) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right: 8, top: 3, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Color(0xff0d9776),
        ),
        color: selectedIndex == index ? Color(0xff0d9776) : Colors.white,
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              listItem[index],
              style: TextStyle(
                color:
                    selectedIndex == index ? Colors.white : Color(0xff0d9776),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.star,
              color: selectedIndex == index ? Colors.white : Color(0xff71b1a1),
            )
          ],
        ),
      ),
    );
  }

  Widget customCategory(index) {
    return ChoiceChip(
      label: Text(categoryList[index].name),
      selected: categoryList[index].name == "Beef",
      selectedColor: Color(0xff0d9776),
      labelStyle: TextStyle(
        color: categoryList[index].name == "Beef"
            ? Colors.white
            : Color(0xff0d9776),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: Colors.white,
      disabledColor: Colors.white,
      showCheckmark: false,
      side: BorderSide(
        color: Color(0xff0d9776),
        width: 0.5,
      ),
      onSelected: (isSelected) {
        setState(() {
          selectedCategoryIndex = isSelected ? index : -1;
        });
      },
    );
  }
}
