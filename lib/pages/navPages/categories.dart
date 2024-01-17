import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/category.model.dart';
import 'package:shopify/pages/products_page.dart';
import 'package:shopify/providers/category_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/widgets/build_category_list_tile_widget.dart';
import 'package:shopify/widgets/headline.widget.dart';
import 'package:shopify/widgets/home/categories_column.home.widget.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({super.key, this.categoryIdForFirst});
  String? categoryIdForFirst;
  List<SubCategoryData>? subCategoryList;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.bgColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: ColorsConstants.badgeColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const HeadlineWidget(title: 'Categories'),
            Row(
              children: [
                //===================== All Categories =====================

                buildCategory(context),
                SizedBox(
                  height: 10.h,
                ),

                buildSubCategory(),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildSubCategory() {
    return Consumer<CategoryProvider>(
      builder: (__, caegoryProvider, _) {
        return FutureBuilder(
            //=====================getsubCategories============================
            future: caegoryProvider.getsubCategories(
                CategoryId: widget.categoryIdForFirst!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error While Get Data');
                } else if (snapshot.hasData) {
                  widget.subCategoryList = snapshot.data!;
                  return Expanded(
                    child: Card(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (catContext, index) {
                            debugPrint(
                                "=============xxxxxx=======${snapshot.data![index].title.toString()}");
                            String subCatTitle =
                                widget.subCategoryList![index].title.toString();
                                 String subCatId =
                                widget.subCategoryList![index].id.toString();
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ProductsPage(
                                                  subCategoryId: subCatId,
                                                )));
                                print(widget.subCategoryList![index].id);
                              },
                              child: CategoryListTileWidget(title: subCatTitle),
                            );
                          }),
                    ),
                  );
                } else {
                  return const Text('No Data Found');
                }
              } else {
                return Text('Connection Statue ${snapshot.connectionState}');
              }
            });
      },
    );
  }

  Widget buildDividerWidget() {
    return const Padding(
      padding: EdgeInsets.only(left: 70.0, right: 25),
      child: Divider(
          // color: ColorsConstants.greyTxtColor,
          ),
    );
  }

  Consumer<CategoryProvider> buildCategory(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (__, caegoryProvider, _) {
        return FutureBuilder(
            future: caegoryProvider.getCategories(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error While Get Data');
                } else if (snapshot.hasData) {
                  //categoryIdForFirst = snapshot.data!.first.id;
                  // debugPrint("xxxxxxxxxxxxxxxxx$categoryIdForFirst");
                  return CategoriesColumnHome(
                    categories: snapshot.data ?? [],
                    selectedCategoryCallBack: (categoryId) async {
                      //=====================getsubCategories for selected category=====================
                      widget.categoryIdForFirst = categoryId;
                      Future<List<SubCategoryData>?> newSubCategoryList =
                          caegoryProvider.getsubCategories(
                              CategoryId: categoryId);
                      widget.subCategoryList = await newSubCategoryList;
                      setState(() {});

                      print(widget.subCategoryList?[0].title.toString());
                    },
                  );
                } else {
                  return const Text('No Data Found');
                }
              } else {
                return Text('Connection Statue ${snapshot.connectionState}');
              }
            });
      },
    );
  }
}
