import 'package:flutter/material.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});
  final String chargeId = 'null';

  //const ComplaintForm({required this.chargeId});

  @override
  ComplaintFormState createState() => ComplaintFormState();
}

class ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  String? message;

  Future<void> _submitComplaint() async {
    if (_formKey.currentState?.validate() ?? false) {
      //await createComplaint(widget.chargeId, _message!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Complaint message',
                  hintText: 'Enter your complaint message here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint message';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: const Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
