import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

class SetPriceScreen extends StatefulWidget {
  final String title;
  final String description;
  final String placeType;
  final List<String> amenities;
  final Function(Map<String, dynamic>) onAddListing;

  const SetPriceScreen({
    required this.title,
    required this.description,
    required this.placeType,
    required this.amenities,
    required this.onAddListing,
    Key? key,
  }) : super(key: key);

  @override
  _SetPriceScreenState createState() => _SetPriceScreenState();
}

class _SetPriceScreenState extends State<SetPriceScreen> {
  int price = 1000;
  File? selectedImage;

  void increasePrice() => setState(() => price += 100);
  void decreasePrice() => setState(() {
        if (price > 100) price -= 100;
      });

  Future<void> pickImage() async {
    final typeGroup = XTypeGroup(label: 'images', extensions: ['jpg', 'png', 'jpeg']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      setState(() => selectedImage = File(file.path));
    }
  }

  void confirmAndAddListing() {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add an image')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Your Listing"),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      selectedImage!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 12),
                Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Hosted by You", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                const Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.description),
                const SizedBox(height: 8),
                const Text("Amenities:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...widget.amenities.map((e) => Text("• $e")).toList(),
                const SizedBox(height: 8),
                Text("₱$price per night", style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onAddListing({
                'title': widget.title,
                'description': widget.description,
                'placeType': widget.placeType,
                'amenities': widget.amenities,
                'price': price,
                'image': selectedImage,
              });
              Navigator.pop(context); 
              Navigator.pop(context); 
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
              const Text("Now, set your price", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text("You can change it anytime.", style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 40),

              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: decreasePrice, icon: const Icon(Icons.remove_circle_outline)),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "₱${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(onPressed: increasePrice, icon: const Icon(Icons.add_circle_outline)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text("per night"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text("Add photo of your place", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.black45),
                        ),
                ),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                  ),
                  ElevatedButton(
                    onPressed: confirmAndAddListing,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text("Add", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
