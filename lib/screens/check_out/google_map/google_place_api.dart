import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

class SearchPlacesApi extends StatefulWidget {
  const SearchPlacesApi({Key? key}) : super(key: key);

  @override
  State<SearchPlacesApi> createState() => _SearchPlacesApiState();
}

class _SearchPlacesApiState extends State<SearchPlacesApi> {
  TextEditingController SearchController=TextEditingController();
  var uuid=Uuid();
  String _sessionToken='1234';
  List<dynamic> placesList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SearchController.addListener(() {
      onChanged();
    });
  }

  void onChanged(){
    if (_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();
      });
    }else{
      getSuggestion(SearchController.text);
    }
  }

  void getSuggestion(String input)async{

    String kPLACES_API_KEY='AIzaSyD2Jb_wLnUAnX-5eifaNR4oY3vsk1fG0hQ';
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response=await http.get(Uri.parse(request));
    var data=response.body.toString();
    print("data");
    print(data);
    print(response.body.toString());

    if(response.statusCode==200){
      placesList=jsonDecode(response.body.toString())['predictions'];
    }else{
      throw Exception('Failed to Load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Search Places Api'),
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: SearchController,
              decoration: InputDecoration(
                hintText: 'Search Places With their Names'
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: placesList.length,
                itemBuilder: (context,index){
              return ListTile(
                onTap: ()async{
                  List<Location> locations=await locationFromAddress(placesList[index]['description']);
                  print(locations.last.longitude);
                  print(locations.last.latitude);
                },
                title: Text(placesList[index]['description']),
              );
            }))
          ],
        ),
      ),
    );
  }
}
