// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  String? _selectedComplaint;
  String _selectedAction = 'Raise Complaint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compaint Upload'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User action',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8.0),
              ToggleButtons(
                isSelected: [_selectedAction == 'Raise Complaint', _selectedAction == 'Check Balance'],
                onPressed: (index) {
                  setState(() {
                    _selectedAction = index == 0 ? 'Raise Complaint' : 'Check Balance';
                  });
                },
                borderRadius: BorderRadius.circular(20.0),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Raise Complaint', style: TextStyle(fontSize: 14)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Check Balance', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Complaint's Title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                title: const Text('Power Surge'),
                leading: Radio(
                  value: 'Power Surge',
                  groupValue: _selectedComplaint,
                  onChanged: (value) {
                    setState(() {
                      _selectedComplaint = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Brokages'),
                leading: Radio(
                  value: 'Brokages',
                  groupValue: _selectedComplaint,
                  onChanged: (value) {
                    setState(() {
                      _selectedComplaint = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Others'),
                leading: Radio(
                  value: 'Others',
                  groupValue: _selectedComplaint,
                  onChanged: (value) {
                    setState(() {
                      _selectedComplaint = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your description of the problem',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const UploadPictureItem(),
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  width: 200.0, // Adjust the width as per your needs
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle complaint submission
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set button color to blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Set button shape to rounded
                      ),
                    ),
                    child: const Text(
                      'Submit Complaint',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signpost_rounded),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1, // Set the current index to 'Complaints'
        onTap: (index) {
          setState(() {
            // Handle navigation to different tabs
          });
        },
      ),
    );
  }
}

class UploadPictureItem extends StatelessWidget {
  const UploadPictureItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Capture complaint (optional)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle camera button press
                    },
                    icon: const Icon(Icons.camera_alt),
                    iconSize: 32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Camera',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle photo icon press
                    },
                    icon: const Icon(Icons.photo),
                    iconSize: 32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Photo',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
