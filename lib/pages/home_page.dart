import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:macska_match/services/cat_service.dart';
import 'package:macska_match/widgets/like_dislike_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final catService = GetIt.instance<CatService>();

  @override
  Widget build(BuildContext context) {
    late Uint8List currentCat;

    return SafeArea(
      child: Column(
        children: [
          Container(
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
                    child: FutureBuilder<Uint8List>(
                        future: catService.getRandomCat(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            currentCat = snapshot.data!;
                            return Image.memory(
                              snapshot.data!,
                              height: 350,
                              fit: BoxFit.cover,
                            );
                          }
                          return Container(
                            height: 350,
                            child: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Spacer(flex: 4),
                        LikeDislikeButton(
                          color: Color.fromRGBO(255, 129, 166, 1),
                          icon: Icons.favorite,
                          onPressed: () {
                            catService.addToLiked(currentCat!);
                            setState(() {});
                          },
                        ),
                        Spacer(flex: 1),
                        LikeDislikeButton(
                          color: Color.fromRGBO(142, 142, 142, 1),
                          icon: Icons.close,
                          onPressed: () {
                            setState(() {});
                            catService.addToDisliked(currentCat!);
                          },
                        ),
                        Spacer(flex: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            margin: EdgeInsets.only(top: 30),
            child: Text('To like a picture of a cat click on the heart icon, or swipe right',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                )),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
