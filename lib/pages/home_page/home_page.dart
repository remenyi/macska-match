import 'package:flutter/material.dart';
import 'package:macska_match/pages/home_page/widgets/swipeable.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          const Expanded(
            flex: 30,
            child: Swipeable(),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                l10n.helper,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
