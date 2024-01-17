import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/product_details.dart';
import 'package:shopify/pages/product_page.dart';
import 'package:shopify/pages/product_reviews.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../providers/product_provider.dart';
import '../widgets/carousel_slider_ex.dart';
import '../widgets/product_app_bar.dart';
class MasterProductPage extends StatefulWidget {
  const MasterProductPage({super.key});

  @override
  State<MasterProductPage> createState() => _MasterProductPageState();
}

class _MasterProductPageState extends State<MasterProductPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isProductAppBar=true;


  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBarEx.getAppBar,
      body: Column(
        children: [
          const SizedBox(height: 20,),
          const AnimatedSmoothIndicator(
            activeIndex: 0,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.orange,
            ),
          ),
          const SizedBox(height: 5,),
         // buildProductCarouselSliderEx(),
          const SizedBox(height: 20,),

          buildTabBar(context),
          buildTabBarPages(),
        ],
      ),

    );
  }
  // Widget buildProductCarouselSliderEx() {
  //   return Consumer<ProductProvider>(builder: (ctx,productProvider,child){
  //     return CarouselSliderEx(
  //         isForProduct: true,
  //         imageUrls:productProvider.Ads  ,
  //         onBtnPressed: () {});
  //   });

  // }


  Widget buildTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            surfaceVariant: Colors.transparent,
          ),
        ),
        child: TabBar(


          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          //indicatorColor: Colors.transparent,
          // change hover color
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color(0xfffffbff); //<-- SEE HERE
              }
              return null;
            },),
          labelColor: ColorsConstants.badgeColor,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white),

          tabs:  [
            // first tab
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 1)),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Product"),
                ),
              ),

            ),

            // second tab
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 1)),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Details"),
                ),
              ),
            ),
            // third tab
            Tab(
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    border: Border.all(color: Colors.white, width: 1)),
    child: const Align(
    alignment: Alignment.center,
    child: Text("Reviews"),
    ),
    ),
    ),

          ],
        ),
      ),
    );
  }


  Widget buildTabBarPages() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          // first tab bar view widget
          ProductPage(),

          // second tab bar view widget
         // ProductDetailsPage(),
          // third tab bar view widget
          ProductReviewsPage()


        ],
      ),
    );
  }


}