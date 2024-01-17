import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/product_details.dart';
import 'package:shopify/providers/product_provider.dart';
import 'package:shopify/widgets/app_bar_ex.widget.dart';
import 'package:shopify/widgets/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required  this.subCategoryId});
  final String subCategoryId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEx.getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [buildProduct(context,widget.subCategoryId)]),
        ),
      ),
    );
  }
}

Consumer<ProductProvider> buildProduct(BuildContext context, String subCategoryId) {
            print(subCategoryId);

  return Consumer<ProductProvider>(
    builder: (__, productProvider, _) {
      return FutureBuilder(
          future: productProvider.getProductsubCategories(subCategoryId:subCategoryId ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error While Get Data');
              } else if (snapshot.hasData) {
                return FlexibleGridView(
                  axisCount: GridLayoutEnum.twoElementsInRow,
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
