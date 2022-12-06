import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

extension BuildContextHelpers on BuildContext {
  void showErrorPopup({required String description, String? details}) {
    showDialog<String>(
      context: this,
      builder: (BuildContext context) {
        final l10n = L10n.of(context)!;

        return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text(l10n.errorOccurred),
            content: details?.isEmpty ?? true
                ? Text(description)
                : ErrorDetails(
              description: description,
              details: details!,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(l10n.ok),
              ),
            ],
          );
      },
    );
  }
}

class ErrorDetails extends StatelessWidget {
  final String description;
  final String details;

  const ErrorDetails({Key? key, required this.description, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

