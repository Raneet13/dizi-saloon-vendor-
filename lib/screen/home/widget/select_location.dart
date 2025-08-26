import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../static/show_toast/showTost_msg.dart';
import '../../../view_model/salon_viewmodel.dart';

class ChooseLocation extends StatefulWidget {
  String? page;
  ChooseLocation({this.page, super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final Completer<GoogleMapController> comController = Completer();
  LatLng _initialPosition = const LatLng(20.2961, 85.8245);
  final DraggableScrollableController sheetController = DraggableScrollableController();

  // Set<Polyline> _polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyAH2um5Dl3iVSCPj2u3F0igZwapRTMziK4";
    var controller =  Get.find<SalonViewmodel>();
  // bool buildFirst = true;

  void _setMapFitToTour(Set<Polyline> p) async {
    // ShowToast(msg: "map Fit Started");
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;
    GoogleMapController controller = await comController.future;

    p.forEach((poly) {
      poly.points.forEach((point) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      });
    });

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        20));

    // Provider.of<MapLoadViewmodel>(context, listen: false).buildfirst = false;
    // setState(() {});
  }

  newCameraLatlng(LatLng loc) async {
    GoogleMapController controller = await comController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: loc,
      zoom: 15,
    )));
    // Provider.of<MapViewModelProvider>(context, listen: false).buildfirst =
    //     false;
    // buildFirst = false;
    // setState(() {});
  }
 Future<LatLng?> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Step 1: Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Prompt user to enable location
    await Geolocator.openLocationSettings();
    return null;
  }

  // Step 2: Check location permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission denied")),
      );
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Location permission permanently denied. Enable it from settings.")),
    );
    return null;
  }

  // Step 3: Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return LatLng(position.latitude, position.longitude);
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
          WidgetsBinding.instance.addPostFrameCallback((_)async{
      LatLng? current = await getCurrentLocation(context);
      if (current != null) {
            _initialPosition = current;
            newCameraLatlng(current);
            controller.updateCurrentLoc(current);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Unable to get current location")),
            );
          }
          setState(() {
            
          });
          });
        }
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.transparent,
        appBar:  AppBar(
                // automaticallyImplyLeading: widget.page == null ? false : true,
                leading: widget.page == null
                    ? null
                    : InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // var mapProvider = Provider.of<MapViewModelProvider>(
                          //     context,
                          //     listen: false);
                          // if (widget.page == "pick" &&
                          //     mapProvider.sourceLocation != null) {
                          //   context.pop();
                          // } else if (widget.page == "dest" &&
                          //     mapProvider.destinationLocation != null) {
                          //   context.pop();
                          // } else if (widget.page == "pick" &&
                          //     mapProvider.sourceLocation == null) {
                          //   ShowToast(msg: "First Choose Pick Up Location");
                          // } else if (widget.page == "dest" &&
                          //     mapProvider.destinationLocation == null) {
                          //   ShowToast(
                          //       msg: "First Choose Destination  Location");
                          // } else {
                          //   ShowToast(msg: "Select the mandatory");
                          // }
                        },
                        child: Icon(Icons.arrow_back)),
              ),
        body: 
          // if (widget.page == "pick") {
          //   value.buildfirst && value.newCameralatLngPickup != null
          //       ? //Future.delayed(Duration(microseconds: 100),
          //       // () =>
          //       newCameraLatlng(value.newCameralatLngPickup!) //)
          //       : null;
          // } else if (widget.page == "dest") {
          //   value.buildfirst && value.newCameraLatLngDest != null
          //       ? //Future.delayed(Duration(milliseconds: 500),
          //       // () =>
          //       newCameraLatlng(value.newCameraLatLngDest!) //)
          //       : null;
          // } else {
          //   // ShowToast(msg: "Load create");
          //   value.buildfirst && value.polylinesProvider.isNotEmpty
          //       ? Future.delayed(Duration(seconds: 3),
          //           () => _setMapFitToTour(value.polylinesProvider))
          //       : null;
          // }
          // return 
          Stack(
            children: [
                  GoogleMap(
                      onMapCreated: (controler) async {
                        comController.complete(controler);
                       
                      },
                      // markers: Set<Marker>.of(value.markers.values),
                      // onTap: (loc) async {
                      //   Provider.of<BookingFormProvider>(context, listen: false)
                      //       .changePickupLoc(loc);
                      // },
                      // mapType: MapType.hybrid,

                      // circles: Set.from(
                      //   [
                      //     Circle(
                      //       circleId: CircleId('currentCircle'),
                      //       center: LatLng(19.1461148379866, 83.4191021368167),
                      //       radius: 10,
                      //       fillColor: Colors.blue.shade100.withOpacity(0.5),
                      //       strokeColor: Colors.blue.shade50.withOpacity(0.1),
                      //     ),
                      //   ],
                      // ),
                      // cameraTargetBounds: CameraTargetBounds.unbounded,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: false,
                      myLocationEnabled: true,
                      indoorViewEnabled: false,
                      trafficEnabled: false,
                      buildingsEnabled: false,
                      myLocationButtonEnabled: true,
                      // style: value.mapStyle,
                      initialCameraPosition: CameraPosition(
                          tilt: 0.0,
                          bearing: 0.0,
                          target: _initialPosition,
                          // widget.page == "dest"
                          //     ? value.destinationLocation ??
                          //         value.currentLocation!
                          //     : value.sourceLocation ?? value.currentLocation!,
                          zoom: 15), //19.1461148379866, 83.4191021368167

                      // markers: Set<Marker>.of(value.markers.values),
                      onCameraMove:(position) {
                        controller.updateCurrentLoc(position.target);
                        // ShowToast(msg: position.target.latitude.toString());
                        print(position.target.latitude);
                              // if (widget.page == "pick") {
                              //   if (value.sourceLocation != position.target) {
                              //     Provider.of<MapViewModelProvider>(context,
                              //             listen: false)
                              //         .sourceLocation = position.target;
                              //   }
                              //   null;
                              // } else if (widget.page == "dest") {
                              //   // ShowToast(
                              //   //     msg:
                              //   //         "${value.currentLocation!.latitude.toString()} current location lat ");
                              //   // ShowToast(
                              //   //     msg:
                              //   //         "${position.target.latitude.toString()} camera position lat");
                              //   // value.cameraMove
                              //   //     ?

                              //   value.cameraMove
                              //       ? {
                              //           Provider.of<MapViewModelProvider>(
                              //               context,
                              //               listen: false)
                              //             ..destinationLocation =
                              //                 position.target
                              //             ..buildfirst = true
                              //         }
                              //       : value.cameraMoveTRue();
                              //   // : value.cameraMove = true;
                              //   // value.currentLocation!.latitude ==
                              //   //         position.target.latitude
                              //   //     ? ShowToast(msg: "True")
                              //   //     : ShowToast(msg: "false");

                              //   // : Provider.of<BookingFormProvider>(context,
                              //   //         listen: false)
                              //   //     .destinationLocation = position.target;
                              // }
                            },
                      onCameraIdle:() {
                       
                            },
                   
                    )
              , Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child:Obx(
                        ()=> controller.currentLocation.value.latitude==0?SizedBox(): SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: Card(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF002B5B)
                                ),
                                  onPressed: () async {
                                     if (controller.isLoading.value) {
                                     ShowToast(msg: "Please wait, Location is updating");
                                   } else {
                                    controller.getPlace(location:  LatLng(controller.currentLocation.value?.latitude??0,controller.currentLocation.value?.longitude??0));
                                   controller.updateLoc(LatLng(controller.currentLocation.value?.latitude??0, 
                                   controller.currentLocation.value?.longitude??0)).then((v){
                                    if (v) {
                                      ShowToast(msg: "Location Updated");
                                   Navigator.pop(context);
                                    }
                                   });
                                   }
                                  
                                  },
                                  child:controller.isLoading.value?Center(child: CircularProgressIndicator(),):  Text("Confirm Location",style: TextStyle(color: Colors.white),)),
                            )),
                      ),
                    ),

              Transform.translate(
                      offset: Offset(0, -25),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                              "assets/icon/ic_pick_48.png"),
                        ),
                        // child: SvgPicture.asset(
                        //   alignment: Alignment.topCenter,
                        //   fit: BoxFit.cover,
                        //   'assets/svg/google_location_marker.svg',
                        //   width: 10.0,
                        //   height: 58.0,
                        //   color: Colors.amber.shade600,
                        // ),
                      ),
                    ),

            
              Positioned(
                      top: MediaQuery.of(context).size.height * 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 17, right: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 3)
                            ]),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 3, bottom: 3),
                        // margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    // height: 5,
                                    // width: 5,
                                    child: Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.green,
                                    ),
                                    // child: Image.asset(
                                    //   'assets/svg/feranta_path_marker.png',
                                    //   height: 25,
                                    //   // color: colorValue,
                                    // ),
                                  ),
                                  // Icon(
                                  //   Icons.arrow_right,
                                  //   color: Colors.red,
                                  //   size: 15,
                                  // ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: 
                                  TextField(
                                    cursorWidth: 1.0,
                                    cursorHeight: 15.0,
                                   

                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                    onChanged: (value) {
                                       sheetController.animateTo(
        0.9, // Fully expanded
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
                                      controller.search(value!);
                                    controller.updatevisible();
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Current Location",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        // filled: true,
                                        // fillColor: Colors.grey.shade200,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        // suffixIcon:IconButton(
                                        //         onPressed: () async {
                                        //           // openDraggableSheet(context);
                                        //           // if (widget.page == "pick") {
                                        //           //   await val
                                        //           //       .PickUpLocationTextnul();
                                        //           //   Provider.of<MapViewModelProvider>(
                                        //           //           context,
                                        //           //           listen: false)
                                        //           //       .onpickpannel();
                                        //           //   val.pickupInputOpen(
                                        //           //       context);
                                        //           // } else if (widget.page ==
                                        //           //     "dest") {
                                        //           //   await val
                                        //           //       .destLocationTextnul();
                                        //           //   Provider.of<MapViewModelProvider>(
                                        //           //           context,
                                        //           //           listen: false)
                                        //                 // controller.onpickpannel();
                                        //           //   val.destInputOpen(context);
                                        //           // }
                                        //         },
                                        //         icon: Icon(
                                        //           Icons.close,
                                        //           color: Colo.buttonPrimary,
                                        //           size: 15,
                                        //         ))
                                           
                                           ), //
                                  ),
                                
                              ),
                            ),
                          ],
                        ),
                      )
                 
                      ),
              Obx(
                ()=>controller.listPlace.value?.predictions==null?SizedBox(): Visibility(
                  visible: controller.isVisible.value,
                  child: DraggableScrollableSheet(
                    controller: sheetController,
                              minChildSize: 0.0,
                              initialChildSize: 0.9, //initial size of bottomsheet
                              // minChildSize: 0.0, //minimum size of bottomsheet
                              // maxChildSize: 0.90, //maximim size of bottomsheet
                              builder: (BuildContext context, scrollController) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      // shrinkWrap: true,
                      // controller: scrollController,
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).hintColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              height: 4,
                              width: 40,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                        controller.listPlace.value?.predictions?.length==0?SingleChildScrollView(
                          controller: scrollController,
                          child:
                            Text("No Location"),
                          
                          ): Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: controller.listPlace.value?.predictions?.length??0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                
                                dense: true,
                                isThreeLine: false,
                                leading: Icon(Icons.location_on),
                                onTap: () {
                                  
                                  controller.getLatlngFronPlace(controller.listPlace.value?.predictions?[index].placeId??"").then((value) {
                                    print(value);
                                    if (value != null) {
                                      controller.updateCurrentLoc(LatLng(value.latitude??0,value.longitude??0));
                                      newCameraLatlng(LatLng(value.latitude, value.longitude));
                                        
                                     controller.updateLoc(LatLng(value.latitude??0,value.longitude??0)).then((v){
                                      if (v) {
                                        ShowToast(msg: "Location Updated");
                                        Navigator.pop(context);
                                //         Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const MainScreen()),
                                // );
                                      }
                                     });
                                    } else {
                                      ShowToast(msg: "No Location Found");
                                    }
                                  });
                                  controller.updatevisible();
                                  setState(() {
                                          
                                        });
                                  // context.go('/home/dest', extra: {'id': "0"});
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => DirectionsView()));
                                },
                                title: Text(
                                  "${controller.listPlace.value?.predictions?[index].structuredFormatting?.mainText??""}",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                subtitle: Text(
                                  "${controller.listPlace.value?.predictions?[index].description}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                            // children: [
                            //   // Your content inside the DraggableScrollableSheet
                            // ],
                          ),
                        ),
                        // Your content inside the DraggableScrollableSheet
                      ],
                    ),
                  );
                              },
                            ),
                ),
              ),
          
            ],
          )
        );
  }
}
