import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/product_details.dart';
import 'package:shopify/providers/ads_provider.dart';
import 'package:shopify/providers/category_provider.dart';
import 'package:shopify/widgets/product.dart';

import '../../providers/product_provider.dart';
import '../../widgets/carousel_slider_ex.dart';
import '../../widgets/headline.widget.dart';
import '../../widgets/home/categories_row.home.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool isLoading = true;
  List productsImages = [
    "assets/images/women_shoes.png",
    "assets/images/backpack.png",
    "assets/images/scarf.png",
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeadlineWidget(title: 'Categories'),
            buildCategory(context),
            const SizedBox(
              height: 10,
            ),
            const HeadlineWidget(title: 'Latest'),
            const SizedBox(
              height: 10,
            ),
            buildCarouselSliderEx(context),

            const HeadlineWidget(title: 'Products'),
            const SizedBox(
              height: 10,
            ),

            buildProduct(context),

            const SizedBox(
              height: 20,
            ),

            //=======================================================
          ],
        ),
      ),
    );
  }

  Consumer<CategoryProvider> buildCategory(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (__, caegoryProvider, _) {
        return FutureBuilder(
            future: caegoryProvider.getCategories(context, limit: 3),
            builder: (curentContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error While Get Data');
                } else if (snapshot.hasData) {
                  return CategoriesRowHome(
                    categories: snapshot.data ?? [],
                   
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

  Consumer<ProductProvider> buildProduct(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (__, productProvider, _) {
        return FutureBuilder(
            future: productProvider.getProducts(context, limit: 3),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error While Get Data');
                } else if (snapshot.hasData) {
                  return FlexibleGridView(
                    axisCount: GridLayoutEnum.threeElementsInRow,
                    shrinkWrap: true,
                    children: snapshot.data
                            ?.map((e) => ProductWidget(
                                  product: e,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ProductDetailsPage(
                                                  product: e,
                                                )));
                                  },
                                ))
                            .toList() ??
                        [],
                  );
                } else {
                  return Text('No Data Found');
                }
              } else {
                return Text('Connection Statue ${snapshot.connectionState}');
              }
            });
      },
    );
  }

  Widget buildCarouselSliderEx(BuildContext context) {
    return Consumer<AdsProvider>(
      builder: (context, adProvider, _) {
        return FutureBuilder(
            future: adProvider.getAds(context, limit: 3),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error While Get Data');
                } else if (snapshot.hasData) {
                  return Container(
                    height: 200,
                    child: CarouselSliderEx(
                        isForProduct: false,
                        imageUrls: snapshot.data ?? [],
                        onBtnPressed: () {}),
                  );
                } else {
                  return Text('No Data Found');
                }
              } else {
                return Text('Connection Statue ${snapshot.connectionState}');
              }
            });
      },
    );
  }

  
}
