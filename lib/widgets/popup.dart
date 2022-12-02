import 'package:flutter/material.dart';

extension BuildContextHelpers on BuildContext {
  void showErrorPopup({required String description, String? details}) {
    showDialog<String>(
      context: this,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text('There was an error!'),
        content: details?.isEmpty ?? true
            ? Text(description)
            : _buildWithDetails(
                description,
                details!,
              ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildWithDetails(String description, String details) {
    return SizedBox(
      height: 300,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(description),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.pinkAccent,
              width: 2,
            ),
          ),
          height: 250,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Text(details),
          ),
        ),
      ]),
    );
  }
}
