import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/check_out/google_map/google_place_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGoogleplex=const CameraPosition(
      target: LatLng(33.787610710615326, 72.72401230766273),
zoom: 14.4746,
  );

  Set<Polygon> _polygone = HashSet<Polygon>() ;

  List<LatLng> points = [
    LatLng(33.787610710615326, 72.72401230766273),
    LatLng(33.791521474260215, 72.75799181300906),
    LatLng(33.76598115668084, 72.76734735743204),
    LatLng(33.77333012891488, 72.77189638361936),
    LatLng(33.78595747294352, 72.73335840705127),
    LatLng(33.78146320794008, 72.72709276720835),
    LatLng(33.77454300547848, 72.72820856608448),
    LatLng(33.77425762430243, 72.72923853427784),
    LatLng(33.77111836862397, 72.72992517974008),
    LatLng(33.76826440001167, 72.74537470264042),
    LatLng(33.787610710615326, 72.72401230766273),
  ] ;




  List<Marker> _marker=<Marker>[];
  List<Marker> _list=[
    Marker(markerId: MarkerId('1'),
    position: LatLng(33.787610710615326, 72.72401230766273),
      infoWindow: InfoWindow(
        title: 'My Current Location'
      )
    )
  ];

  // Future<Position> _getUserCurrentLocation() async {
  //
  //
  //   await Geolocator.requestPermission().then((value) {
  //
  //   }).onError((error, stackTrace){
  //     print(error.toString());
  //   });
  //
  //   return await Geolocator.getCurrentPosition();
  //
  // }
  //
  // loadData(){
  //   _getUserCurrentLocation().then((value)async {
  //     print(value.longitude.toString()+""+value.latitude.toString());
  //     _marker.add(
  //         Marker(markerId: MarkerId('2'),
  //             position: LatLng(value.longitude,value.latitude),
  //             infoWindow: InfoWindow(
  //                 title: "My Location"
  //             )
  //         )
  //     );
  //     CameraPosition cameraPosition=CameraPosition(zoom:14,target: LatLng(value.longitude,value.latitude));
  //     final GoogleMapController controller=await _controller.future;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //     setState(() {
  //
  //     });
  //   });
  // }
  //

  void _setPolygone(){
    _polygone.add(
        Polygon(polygonId: PolygonId('1') ,
            points: points ,
            strokeColor: Colors.deepOrange,
            strokeWidth: 5 ,
            fillColor: Colors.deepOrange.withOpacity(0.1),
            geodesic: true
        )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolygone() ;
    _marker.addAll(_list);
   // loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogleplex,
          mapType: MapType.normal,
          markers:Set<Marker>.of(_marker) ,
          polygons: _polygone,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 45),
        child: FloatingActionButton(
          child: Icon(Icons.location_disabled_outlined),
          onPressed: ()async{
            //_getUserCurrentLocation();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPlacesApi()));
            GoogleMapController controller=await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(33.787610710615326, 72.72401230766273),zoom: 14)
            )
            );
            setState(() {

            });
          },
        ),
      ),
    );
  }
}



// SafeArea(
// child: Container(
// height: MediaQuery.of(context).size.height,
// width: MediaQuery.of(context).size.width,
// child: Stack(
// children: [
// GoogleMap(
// initialCameraPosition:
// CameraPosition(target: _initialcameraposition),
// mapType: MapType.normal,
// onMapCreated: _onMapCreated,
// // mapToolbarEnabled: true,
// myLocationEnabled: true,
// ),
// Positioned(
// bottom: 0,
// left: 0,
// right: 0,
// child: Container(
// height: 50,
// color: primaryColor,
// width: double.infinity,
// margin: EdgeInsets.only(
// right: 60, left: 10, top: 40, bottom: 40),
// child: MaterialButton(
// onPressed: () async{
// await _location.getLocation().then((value) {
// setState(() {
// checkOutProvider.setLocation!=value;
// });
// });
// },
// child: Text('Set Location'),
// shape: StadiumBorder(),
// ),
// ))
// ],
// ),
// ),
// ),









// LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
// late GoogleMapController controller;
// Location _location = Location();
// void _onMapCreated(GoogleMapController _value) {
//   controller = _value;
//   _location.onLocationChanged.listen((event) {
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: LatLng(event.longitude!, event.longitude!),zoom: 15
//     )));
//   });
// }