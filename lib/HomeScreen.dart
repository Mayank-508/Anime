import 'package:flutter/material.dart';
import 'package:untitled2/FavouriteList.dart';
import 'package:untitled2/webtoons.dart';

import 'DetailScreen.dart';
import 'FavouriteScreen.dart';

class HomeScreen extends StatelessWidget {
  final Favourite f = Favourite();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Webtoon Categories',
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              await f.loadFavourites();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteScreen(f: f),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: screenWidth * 0.0615,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.01,
            left: screenWidth * 0.09,
            right: screenWidth * 0.09,
            bottom: screenHeight * 0.01,
          ),
          child: ListView.builder(
            itemCount: (category.length),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(wc: category[index], f: f)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            fit: BoxFit.cover,
                            category[index].imgUrl,
                            width: screenWidth * 0.82,
                            height: screenHeight * 0.25,
                          )),
                      SizedBox(
                        height: screenHeight * .008,
                      ),
                      Text(
                        category[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth *
                              0.055, // Increase the size for emphasis

                          color: Colors.black, // White text color

                          letterSpacing:
                              screenWidth * 0.002, // Adds space between letters
                          fontStyle: FontStyle.normal,
                          // Change the underline color
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, int index) async {
    await f.loadFavourites();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          wc: category[index],
          f: f,
        ),
      ),
    );
  }
}
