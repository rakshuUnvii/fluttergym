import 'package:flutter/material.dart';
import 'package:fluttergym/model/gymlistcategorymodel.dart';
import 'package:fluttergym/repo/gymrepo.dart';

class GymDetailsScreen extends StatefulWidget {
  final String? name;
  final int? categoryId;

  const GymDetailsScreen({
    Key? key,
    required this.name,
    this.categoryId,
  }) : super(key: key);

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  GymListCategoryModel? gymListData;
  bool gymLoading = true;

  @override
  void initState() {
    fetchgymList();
    super.initState();
  }

  fetchgymList() async {
    await GymLisrRepo().gymlistRepo(widget.categoryId).then((value) {
      setState(() {
        gymListData = value;
        gymLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name ?? "Gym Details",
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      backgroundColor: Colors.black,
      body: gymLoading
          ? const Center(child: CircularProgressIndicator())
          : gymListData != null && gymListData!.data!.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: gymListData!.data!.length,
                  itemBuilder: (context, index) {
                    final gym = gymListData!.data![index];
                    return Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://gymwise.in/uploads/gym/1671689657.gym.png",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        gym.gymName!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                           const Icon(Icons.location_on,
                                              color: Colors.white70, size: 20),
                                                     const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              gym.address!,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                         const Icon(Icons.stop_circle,
                                            color: Colors.white, size: 20),
                                        const SizedBox(width: 4),
                                        Text(
                                          gym.open!,
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.yellow, size: 20),
                                        const SizedBox(width: 4), // Added space between icon and text
                                        Text(
                                          gym.rating!,
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: gym.amenities!.map((amenity) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      label: Text(
                                        amenity.name ?? '',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text("No Gym Data Available",
                      style: TextStyle(color: Colors.white))),
    );
  }
}
