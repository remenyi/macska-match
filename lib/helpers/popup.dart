import 'package:flutter/material.dart';

extension BuildContextHelpers on BuildContext {
  void showErrorPopup({required String description}) {
    showDialog<String>(
      context: this,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text('There was an error!'),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
