import 'package:flutter/material.dart';
import 'package:untitled2/DetailScreen.dart';
import 'package:untitled2/FavouriteList.dart';

class FavouriteScreen extends StatefulWidget {
  final Favourite f;
  FavouriteScreen({super.key, required this.f});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    widget.f.loadFavourites().then((_) {
      setState(() {
        // This will rebuild the UI after loading the favorites
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(
            "Favourite Webtoon",
            style: TextStyle(
              fontSize: screenWidth * 0.06,
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
        ),
        body: widget.f.fav_list.isEmpty
            ? Center(child: Text("Nothing is added to the favourites"))
            : Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.011,
                  right: screenWidth * 0.011,
                  bottom: screenHeight * 0.01,
                ),
                child: ListView.builder(
                  itemCount: widget.f.fav_list.length,
                  itemBuilder: (context, index) {
                    String truncate(String des, int limit) {
                      List<String> words = des.split(' ');
                      if (words.length > limit) {
                        return words.sublist(0, limit).join(' ') + '...';
                      }
                      return des;
                    }

                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  wc: widget.f.fav_list[index], f: widget.f),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.06,
                          backgroundImage:
                              AssetImage(widget.f.fav_list[index].imgUrl),
                        ),
                      ),
                      title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    wc: widget.f.fav_list[index], f: widget.f),
                              ),
                            );
                          },
                          child: Text(
                            widget.f.fav_list[index].title,
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              letterSpacing: screenWidth * 0.002,
                            ),
                          )),
                      subtitle: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  wc: widget.f.fav_list[index], f: widget.f),
                            ),
                          );
                        },
                        child: Text(
                          truncate(widget.f.fav_list[index].detail, 10),
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.04, // Adjust font size for the subtitle
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          widget.f.fav_rem(widget.f.fav_list[index]);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: screenWidth * 0.06, // Responsive icon size
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
