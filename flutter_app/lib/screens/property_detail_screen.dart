import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class ListingDetailScreen extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;

  const ListingDetailScreen({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  _ListingDetailScreenState createState() => _ListingDetailScreenState();
  
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  void _showPaymentMethodPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedMethod; // define outside of StatefulBuilder

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Payment Method"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    activeColor: Colors.black, // Set this to make selected radio stand out
                    title: const Text("Cash on Hand"),
                    value: "Cash on Hand",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: Colors.black,
                    title: const Text("GCash"),
                    value: "GCash",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: Colors.black,
                    title: const Text("Credit/Debit Card"),
                    value: "Card",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),

                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedMethod != null) {
                      Navigator.pop(context); // Close popup
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PaymentSuccessScreen()),
                      );
                    }
                  },
                  child: const Text("Confirm", style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          },
        );
      },
    );
  }



  int get totalNights {
    if (_checkInDate != null && _checkOutDate != null) {
      return _checkOutDate!.difference(_checkInDate!).inDays;
    }
    return 0;
  }

  double get totalPrice {
    final priceValue = double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9\.]'), '')) ?? 0;
    return priceValue * totalNights;
  }

  Future<void> _selectDate({required bool isCheckIn}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? (_checkInDate ?? DateTime.now())
          : (_checkOutDate ?? (_checkInDate?.add(const Duration(days: 1)) ?? DateTime.now())),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final isReadyToBook = _checkInDate != null && _checkOutDate != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(widget.imagePath, height: 220, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              const Text("4.8", style: TextStyle(fontWeight: FontWeight.w500)),
              const Spacer(),
              Text(
                widget.price,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Hosted by Juan Dela Cruz", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text(
            "This is a sample listing description with great amenities and an ideal location for your stay. Feel at home!",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 24),

          ListTile(
            title: const Text("Check-in Date"),
            subtitle: Text(
              _checkInDate != null
                  ? "${_checkInDate!.month}/${_checkInDate!.day}/${_checkInDate!.year}"
                  : "Select check-in date",
            ),
            trailing: ElevatedButton(
              onPressed: () => _selectDate(isCheckIn: true),
              child: const Text("Select"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ),

          ListTile(
            title: const Text("Check-out Date"),
            subtitle: Text(
              _checkOutDate != null
                  ? "${_checkOutDate!.month}/${_checkOutDate!.day}/${_checkOutDate!.year}"
                  : "Select check-out date",
            ),
            trailing: ElevatedButton(
              onPressed: _checkInDate != null ? () => _selectDate(isCheckIn: false) : null,
              child: const Text("Select"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ),

          if (totalNights > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "$totalNights night(s) • Total: ₱${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: isReadyToBook
                ? () => _showPaymentMethodPopup(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              isReadyToBook ? "Check-in & Pay ₱${totalPrice.toStringAsFixed(2)}" : "Select Dates to Book",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
