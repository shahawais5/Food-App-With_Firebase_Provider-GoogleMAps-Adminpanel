import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/single_items.dart';
import '../../model/product_model.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  Search({super.key, required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query="";

  searchItem(String query){
    List<ProductModel>searchFood=widget.search.where((element){
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel>_searchItem=searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6b738),
        title: Text('Search'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.menu_rounded),
          )
        ],
      ),
      body: ListView(
        children: [
          Text('Items'),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  query=value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: 'Search here',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: _searchItem.map((data) {
              return SignleItem(
                isbool: false,
                productPrice: data.productPrice,
                productName: data.productName,
                productImage: data.productImage,
                productID: data.productID,
                productQuantity: data.productPrice,
                productUnit: data.productUnit,
                wishList: true,
                onDelete: (){},
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
