import 'package:flutter/material.dart';
import 'package:macska_match/services/cat_service.dart';
import 'package:get_it/get_it.dart';

class LikedPage extends StatelessWidget {
  LikedPage({Key? key}) : super(key: key);
  final catService = GetIt.instance<CatService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            'Liked cats',
            style: TextStyle(
              color: Color.fromRGBO(255, 111, 127, 1),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: catService.likedCats.length,
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
                        child: Image.memory(catService.likedCats[index],
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
