import 'package:flutter/material.dart';
import 'package:macska_match/widgets/like_dislike_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: Image.network('https://placeimg.com/640/480/any',
                        // width: 300,
                        height: 350,
                        fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Spacer(flex: 4),
                        LikeDislikeButton(
                          color: Color.fromRGBO(255, 129, 166, 1),
                          icon: Icons.favorite,
                        ),
                        Spacer(flex: 1),
                        LikeDislikeButton(
                          color: Color.fromRGBO(142, 142, 142, 1),
                          icon: Icons.close,
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
