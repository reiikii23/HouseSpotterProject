import 'package:flutter/material.dart';
import 'listing_screen3.dart';

class SelectAmenitiesScreen extends StatefulWidget {
  final String placeType;
  final String title;
  final String description;
  final Function(Map<String, dynamic>) onAddListing;

  const SelectAmenitiesScreen({
    required this.placeType,
    required this.title,
    required this.description,
    required this.onAddListing,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectAmenitiesScreen> createState() => _SelectAmenitiesScreenState();
}

class _SelectAmenitiesScreenState extends State<SelectAmenitiesScreen> {
  final List<Map<String, dynamic>> amenities = [
    {'label': 'Wi-Fi', 'icon': Icons.wifi},
    {'label': 'Kitchen', 'icon': Icons.kitchen},
    {'label': 'Washer', 'icon': Icons.local_laundry_service},
    {'label': 'TV', 'icon': Icons.tv},
    {'label': 'Aircon', 'icon': Icons.ac_unit},
    {'label': 'Parking', 'icon': Icons.local_parking},
  ];

  Set<String> selectedAmenities = {};

  void toggleAmenity(String amenity) {
    setState(() {
      if (selectedAmenities.contains(amenity)) {
        selectedAmenities.remove(amenity);
      } else {
        selectedAmenities.add(amenity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tell guests what your place has to offer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text("You can add more amenities later.",
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              SizedBox(height: 30),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3,
                  children: amenities.map((item) {
                    final isSelected = selectedAmenities.contains(item['label']);
                    return GestureDetector(
                      onTap: () => toggleAmenity(item['label']),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? Colors.black12.withOpacity(0.05) : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(item['icon'], color: Colors.black),
                            SizedBox(width: 8),
                            Text(item['label']),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Back", style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                  ),
                  ElevatedButton(
                    onPressed: selectedAmenities.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SetPriceScreen(
                                  title: widget.title,
                                  description: widget.description,
                                  placeType: widget.placeType,
                                  amenities: selectedAmenities.toList(),
                                  onAddListing: widget.onAddListing,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text("Next", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
