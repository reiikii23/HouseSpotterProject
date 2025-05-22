import 'package:flutter/material.dart';
import 'listing_screen2.dart'; // Import your amenities screen

class SelectPlaceTypeScreen extends StatefulWidget {
  @override
  _SelectPlaceTypeScreenState createState() => _SelectPlaceTypeScreenState();
}

class _SelectPlaceTypeScreenState extends State<SelectPlaceTypeScreen> {
  String? selectedType;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<Map<String, dynamic>> types = [
    {'label': 'Transient', 'icon': Icons.apartment},
    {'label': 'House', 'icon': Icons.house},
    {'label': 'Apartment', 'icon': Icons.location_city},
    {'label': 'Bedspace', 'icon': Icons.hotel},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Which of these best describes your place?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Title input
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter a title for your listing',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Description input
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Add some details about the place',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Place type grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: types.map((type) {
                    final isSelected = selectedType == type['label'];
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedType = type['label']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(type['icon'], size: 36),
                              SizedBox(height: 8),
                              Text(type['label']),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: selectedType != null &&
                            titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SelectAmenitiesScreen(
                                  placeType: selectedType!,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
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
