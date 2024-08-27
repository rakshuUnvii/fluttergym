import 'package:flutter/material.dart';
import 'package:fluttergym/model/categorylistmodel.dart';
import 'package:fluttergym/repo/gymrepo.dart';
import 'package:fluttergym/screens/gymdetails.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LatLng _center = const LatLng(28.5848, 77.3200); 
  CategoryListModel? categoryListData;
  bool categoryLoading = true;
  String _address = "Address will be here";
  LatLng? _currentLocation;
  List<dynamic> gymData = []; 

  @override
  void initState() {
    super.initState();
    fetchActivitiesData();
    getLocation();
  }

  Future<void> fetchActivitiesData() async {
    await CategoryRepository().fetchCategories().then((value) {
      setState(() {
        categoryListData = value;
        categoryLoading = false;
      });
    });
  }

  Future<void> getLocation() async {
    final location = await getCurrentLocation();

    if (location != null) {
      setState(() {
        _currentLocation = LatLng(location.latitude, location.longitude);
        getAddressFromLatLng(_currentLocation!);
        fetchGymData(location.latitude, location.longitude); 
      });
    }
  }

  Future<void> getAddressFromLatLng(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final placemark = placemarks[0];
      setState(() {
        _address = '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      });
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  Future<LatLng?> getCurrentLocation() async {

    return _center; 
  }

  Future<void> fetchGymData(double latitude, double longitude) async {
    const url = 'https://gymwise.in/api/v1/customer/gymList';
    try {
      final response = await http.get(Uri.parse('$url?latitude=$latitude&longitude=$longitude'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          gymData = data['data'] ?? []; 
        });
      } else {
        setState(() {
          gymData = _fallbackData['data'];
        });
      }
    } catch (e) {
      setState(() {
        gymData = _fallbackData['data'];
      });
    }
  }


  final Map<String, dynamic> _fallbackData = {
    "status": true,
    "message": "Data Found",
    "message_ios": "Data Found",
    "data": [
      {
        "gym_id": 357,
        "gym_name": "Tech Gym",
        "gym_logo": "640193c94308b-1677824969.jpg",
        "gym_images": [
          "64019c7580783-1677827189.jpg",
          "64019c75810e8-1677827189.jpg"
        ],
        "address": "132, C Block, Sector 2, Noida, Uttar Pradesh 201301, India",
        "city_name": "Delhi",
        "description": "<p>​​​Description - one of the best gym of our locality ​​​Description - one of the best gym of our locality ​​​Description - one of the best gym of our locality ​​​Description - one of the best gym of our locality&nbsp;</p>",
        "how_to_get": "<p>​​​Sector 2 4th building​​​Sector 2 4th building​​​Sector 2 4th building​​​Sector 2 4th building</p>",
        "partner_name": "Deepansha Sagara",
        "partner_email": "deepansha@mailinator.com",
        "partner_phone": "9643624962",
        "phone_code": "91",
        "latitude": "28.583745",
        "longitude": "77.3155413",
        "amenities": [
          {
            "id": 1,
            "name": "Steam Bath",
            "icon": "https://gymwise.in/uploads/amenity-icon/1641556324.png"
          },
          {
            "id": 13,
            "name": "Parking",
            "icon": "https://gymwise.in/uploads/amenity-icon/1677846476.png"
          },
          {
            "id": 14,
            "name": "Private Restroom",
            "icon": "https://gymwise.in/uploads/amenity-icon/1652076950.png"
          },
          {
            "id": 15,
            "name": "Private Lockers",
            "icon": "https://gymwise.in/uploads/amenity-icon/1677846665.png"
          },
          {
            "id": 17,
            "name": "Changing Rooms",
            "icon": "https://gymwise.in/uploads/amenity-icon/1677846581.png"
          }
        ],
        "gym_images2": [
          "https://gymwise.in/uploads/gym/64019c7580783-1677827189.jpg",
          "https://gymwise.in/uploads/gym/64019c75810e8-1677827189.jpg"
        ],
        "open": "11:00 - 21:00",
        "rating": "0/5 (0 Review)",
        "categories": [
          {
            "pricing_id": 194,
            "category_name": "Strengthening",
            "category_id": 2,
            "price": [
              {
                "hour": 1,
                "rate": 10
              },
              {
                "hour": 2,
                "rate": 19
              },
              {
                "hour": 3,
                "rate": 29
              }
            ]
          },
          {
            "pricing_id": 195,
            "category_name": "Cardio",
            "category_id": 5,
            "price": [
              {
                "hour": 1,
                "rate": 10
              },
              {
                "hour": 2,
                "rate": 19
              },
              {
                "hour": 3,
                "rate": 29
              }
            ]
          }
        ],
        "distance": "1.03 km",
        "img_path": "https://gymwise.in/uploads/gym",
        "avaliable_slots": "0"
      },
      {
        "gym_id": 353,
        "gym_name": "Vk Builder Group",
        "gym_logo": "63ec9a0d2c6ad-1676450317.jpg",
        "gym_images": [
          "63ec9a0d2c3b7-1676450317.jpg",
          "63ec99b8ee4f9-1676450232.jpg",
          "1678095919.11.png"
        ],
        "address": "131, C Block, Sector 2, Noida, Uttar Pradesh 201301, India",
        "city_name": "Noida",
        "description": "<p>​​​​description</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>",
        "how_to_get": "<p>​​​s traitor</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>",
        "partner_name": "vishl singh",
        "partner_email": "v@yopmail.com",
        "partner_phone": "9892317198",
        "phone_code": "91",
        "latitude": "28.5838511",
        "longitude": "77.3156517",
        "amenities": [
          {
            "id": 12,
            "name": "Sauna Bath",
            "icon": "https://gymwise.in/uploads/amenity-icon/1652076895.png"
          }
        ],
        "gym_images2": [
          "https://gymwise.in/uploads/gym/63ec9a0d2c3b7-1676450317.jpg",
          "https://gymwise.in/uploads/gym/63ec99b8ee4f9-1676450232.jpg",
          "https://gymwise.in/uploads/gym/1678095919.11.png"
        ],
        "open": "01:00 - 23:00",
        "rating": "0/5 (0 Review)",
        "categories": [
          {
            "pricing_id": 193,
            "category_name": "Aerobic exercise",
            "category_id": 1,
            "price": [
              {
                "hour": 1,
                "rate": 1
              },
              {
                "hour": 2,
                "rate": 1
              },
              {
                "hour": 3,
                "rate": 1
              }
            ]
          }
        ],
        "distance": "1.03 km",
        "img_path": "https://gymwise.in/uploads/gym",
        "avaliable_slots": "0"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Text(
                          _address,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              headingText("FITNESS LOCATION FOR YOU"),
              const SizedBox(height: 15),
              fitnessTile(gymData), // Pass gym data here
              const SizedBox(height: 15),
              headingText("ACTIVITIES FOR YOU"),
              const SizedBox(height: 15),
              activitiesList(categoryListData, categoryLoading),
              const SizedBox(height: 15),
              headingText("AROUND YOU"),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation ?? _center,
                        zoom: 14.0,
                      ),
                      markers: _createMarkers(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Set<Marker> _createMarkers() {
  return gymData.map((gym) {
    final lat = double.tryParse(gym['latitude']) ?? 0.0;
    final lng = double.tryParse(gym['longitude']) ?? 0.0;
    return Marker(
      markerId: MarkerId(gym['gym_id'].toString()),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: gym['gym_name'],
        snippet: gym['address'],
      ),
    );
  }).toSet();
}

Widget headingText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget fitnessTile(List<dynamic> gymData) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: gymData.length,
      itemBuilder: (context, index) {
        final gym = gymData[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://gymwise.in/uploads/gym/${gym['gym_logo']}',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  color: const Color.fromARGB(255, 66, 65, 65),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 40,
                        color: Colors.grey,
                        child: Image.network(
                          'https://gymwise.in/uploads/gym/${gym['gym_logo']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        gym['gym_name'] ?? 'No Name',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget activitiesList(
    CategoryListModel? categoryListData, bool categoryLoading) {
  if (categoryLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (categoryListData == null || categoryListData.data!.isEmpty) {
    return const Center(
      child: Text(
        'No activities found',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  return SizedBox(
    height: 150,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryListData.data!.length,
      itemBuilder: (context, index) {
        final category = categoryListData.data![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GymDetailsScreen(
                          name: categoryListData.data?[index].name,
                          categoryId: categoryListData.data?[index].id,
                        )),
              );
            },
            child: SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: category.icon != null
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            child: Image.network(
                              category.icon!,
                              fit: BoxFit.contain,
                              width: 40,
                              height: 40,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        category.name ?? 'No Name',
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
}