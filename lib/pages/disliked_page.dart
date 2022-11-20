import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:macska_match/services/cat_service.dart';

class DislikedPage extends StatelessWidget {
  DislikedPage({Key? key}) : super(key: key);
  final catService = GetIt.instance<CatService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            'Disliked cats',
            style: TextStyle(
              color: Color.fromRGBO(255, 111, 127, 1),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: catService.dislikedCats.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Image.memory(catService.dislikedCats[index],
                            // width: 300,
                            height: 200,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
