import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/product_provider.dart';
import 'package:food_delivery_app/providers/user_provider.dart';
import 'package:food_delivery_app/screens/home/single_product.dart';
import 'package:food_delivery_app/screens/product_overview/product_overview.dart';
import 'package:food_delivery_app/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';
import '../../config_color/colors.dart';
import 'package:food_delivery_app/screens/Search/search.dart';
import 'drawer_side.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Herbs Seasoning'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(
                                search: productProvider.getHerbsProductDataList,
                              )));
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: productProvider.getHerbsProductDataList
                  .map((herbsProductData) {
            return SingleProduct(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductOverview(
                              productImage: herbsProductData.productImage,
                              productName: herbsProductData.productName,
                              productPrice: herbsProductData.productPrice,
                              productID: herbsProductData.productID,
                            )));
              },
              productName: herbsProductData.productName,
              productImage: herbsProductData.productImage,
              productPrice: herbsProductData.productPrice,
              productID: herbsProductData.productID,
              productUnit: herbsProductData,
            );
          }).toList()),
        )
      ],
    );
  }

  Widget _buildFreshProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fresh Fruits'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(
                                search: productProvider.getFreshProductDataList,
                              )));
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: productProvider.getFreshProductDataList
                  .map((freshProductData) {
            return SingleProduct(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductOverview(
                              productName: freshProductData.productName,
                              productImage: freshProductData.productImage,
                              productID: freshProductData.productID,
                              productPrice: freshProductData.productPrice,
                            )));
              },
              productName: freshProductData.productName,
              productImage: freshProductData.productImage,
              productID: freshProductData.productID,
              productPrice: freshProductData.productPrice,
              productUnit: freshProductData
              ,
            );
          }).toList()),
        )
      ],
    );
  }

  Widget _buildRootProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Root Vegetables'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(
                                search: productProvider.getrootProductDataList,
                              )));
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children:
                  productProvider.getrootProductDataList.map((rootProductData) {
            return SingleProduct(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductOverview(
                              productName: rootProductData.productName,
                              productImage: rootProductData.productImage,
                              productID: rootProductData.productID,
                              productPrice: rootProductData.productPrice,
                            )));
              },
              productName: rootProductData.productName,
              productImage: rootProductData.productImage,
              productID: rootProductData.productID,
              productPrice: rootProductData.productPrice,
              productUnit: rootProductData,
            );
          }).toList()),
        )
      ],
    );
  }

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fetchHerbsProductData();
    initproductProvider.fatchFreshProductData();
    initproductProvider.fatchRootProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: scafoldbackgroundColor,
      drawer: DrawerScreen(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: primaryColor,
        actions: [
          CircleAvatar(
            radius: 12,
            backgroundColor:  Colors.black,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(
                              search: productProvider.getallproductsearchdata,
                            )));
              },
              icon:Icon(
                Icons.search,
                size: 17,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewCart()));
            },
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.shop,
                size: 17,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.AQ_edv3k0oOSfNAJ02FCdQHaE8?pid=ImgDet&w=1920&h=1280&rs=1'),
                ),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 29, bottom: 10),
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: const BoxDecoration(
                                color: Color(0xffaed581),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: const Center(
                              child: Text('Vegi',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.green,
                                        )
                                      ])),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 130),
                          child: Text(
                            '30% OFF',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 130),
                          child: Text(
                            'On all vegitables Product',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildHerbsProduct(context),
            _buildFreshProduct(context),
            _buildRootProduct(context),
            _buildHerbsProduct(context),
            _buildFreshProduct(context),
            _buildRootProduct(context),
          ],
        ),
      ),
    );
  }
}

