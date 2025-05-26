import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'listing_screen1.dart';
import 'menu_screen.dart';
import 'property_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<Map<String, String>>> categoryListings = {
    'Transient': [
      {'image': 'assets/transi1.jpg', 'price': '₱1,000'},
      {'image': 'assets/transi2.jpg', 'price': '₱1,200'},
    ],
    'Apartment': [
      {'image': 'assets/apt1.jpg', 'price': '₱2,000'},
      {'image': 'assets/apt2.jpg', 'price': '₱2,200'},
    ],
    'House': [
      {'image': 'assets/house1.jpg', 'price': '₱3,000'},
      {'image': 'assets/house2.jpg', 'price': '₱3,500'},
    ],
    'Bedspace': [
      {'image': 'assets/bedspace1.jpg', 'price': '₱500'},
      {'image': 'assets/bedspace2.jpg', 'price': '₱700'},
    ],
  };

  final List<Map<String, dynamic>> userListings = [];
  final MapController _mapController = MapController();
  String selectedCategory = 'Transient';
  int _selectedIndex = 0;
  String searchText = '';
  String inboxFilter = 'All';

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, String>> _getFilteredListings() {
    if (searchText.isEmpty) {
      return categoryListings[selectedCategory] ?? [];
    }

    List<Map<String, String>> allResults = [];
    categoryListings.forEach((category, listings) {
      for (var listing in listings) {
        if (category.toLowerCase().contains(searchText.toLowerCase()) ||
            listing['price']!.toLowerCase().contains(searchText.toLowerCase())) {
          allResults.add({
            ...listing,
            'category': category,
          });
        }
      }
    });
    return allResults;
  }

  Widget buildListingsContent() {
    if (userListings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No Listings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectPlaceTypeScreen(
                      onAddListing: (listingData) {
                        setState(() {
                          userListings.add(listingData);
                        });
                      },
                    ),
                  ),
                );
              },
              child: const Text(
                "Add a listing",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: userListings.length,
        itemBuilder: (context, index) {
          final listing = userListings[index];
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listing['image'] != null && listing['image'] is File)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.file(
                      listing['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listing['title'] ?? 'No Title',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(listing['description'] ?? ''),
                      const SizedBox(height: 8),
                      Text('₱${listing['price']} per night'),
                      Text('Type: ${listing['placeType']}'),
                      Text('Amenities: ${listing['amenities'].join(', ')}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget buildMapContent() {
    return Stack(
      children: [
        SizedBox.expand(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(14.5995, 120.9842), 
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app1',
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: 'zoomIn',
                mini: true,
                backgroundColor: Colors.black,
                onPressed: () {
                  final zoom = _mapController.zoom + 1;
                  _mapController.move(_mapController.center, zoom);
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoomOut',
                mini: true,
                backgroundColor: Colors.black,
                onPressed: () {
                  final zoom = _mapController.zoom - 1;
                  _mapController.move(_mapController.center, zoom);
                },
                child: const Icon(Icons.remove, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget buildInboxContent() {
  final TextEditingController _supportController = TextEditingController();

  return Stack(
    children: [
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text("All"),
                selected: inboxFilter == 'All',
                onSelected: (_) => setState(() => inboxFilter = 'All'),
              ),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text("Host Chats"),
                selected: inboxFilter == 'Host Chats',
                onSelected: (_) => setState(() => inboxFilter = 'Host Chats'),
              ),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text("Support"),
                selected: inboxFilter == 'Support',
                onSelected: (_) => setState(() => inboxFilter = 'Support'),
              ),
            ],
          ),
          const Spacer(),
          const Text("You don’t have any messages", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("When you receive a new message, it will appear here."),
          const Spacer(),
        ],
      ),
      Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Contact Support", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _supportController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Describe your issue...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("The support team will let you know soon.")),
                        );
                        _supportController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Send", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          child: const Icon(Icons.support_agent, color: Colors.white),
        ),
      ),
    ],
  );
}


  Widget buildHomeContent() {
    final filteredListings = _getFilteredListings();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            onChanged: (value) => setState(() => searchText = value),
            decoration: InputDecoration(
              hintText: 'Search places',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: categoryListings.keys.map((category) {
              final isSelected = selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => setState(() {
                    selectedCategory = category;
                    searchText = '';
                  }),
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: filteredListings.isEmpty
              ? const Center(child: Text("No listings found."))
              : ListView.builder(
                  itemCount: filteredListings.length,
                  itemBuilder: (_, index) {
                    final listing = filteredListings[index];
                    final category = listing['category'] ?? selectedCategory;
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListingDetailScreen(
                            imagePath: listing['image']!,
                            title: category,
                            price: listing['price']!,
                          ),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                listing['image']!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 24,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    listing['price']!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_selectedIndex == 0) {
      content = buildHomeContent();
    } else if (_selectedIndex == 1) {
      content = buildMapContent();
    } else if (_selectedIndex == 2) {
      content = buildInboxContent();
    } else {
      content = buildListingsContent();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          () {
            switch (_selectedIndex) {
              case 0:
                return selectedCategory.toUpperCase();
              case 1:
                return 'Places';
              case 2:
                return 'Inbox';
              case 3:
                return 'Listings';
              default:
                return '';
            }
          }(),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen(user: widget.user)),
              );
            },
          ),
        ],
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Listings'),
        ],
      ),
    );
  }
}
