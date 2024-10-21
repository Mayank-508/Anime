import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/FavouriteList.dart';

import 'WebtoonCategory.dart';

class DetailScreen extends StatefulWidget {
  final Favourite f;

  final WebtoonCategory wc;

  DetailScreen({super.key, required this.wc, required this.f});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selected = 0;
  int ratingCount = 0;
  double avgRating = 0;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _loadRating();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    await widget.f.loadFavourites();
    setState(() {
      isFav = widget.f.isFavorite(widget.wc);
    });
  }

  Future<void> _saveRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${widget.wc.title}_ratingCount', ratingCount);
    await prefs.setDouble('${widget.wc.title}_avgRating', avgRating);
  }

  Future<void> _loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ratingCount = prefs.getInt('${widget.wc.title}_ratingCount') ?? 0;
      avgRating = prefs.getDouble('${widget.wc.title}_avgRating') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
        centerTitle: true,
        title: Text(
          widget.wc.title,
          style: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(widget.wc.imgUrl),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.wc.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.wc.detail,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  "Rate this Webtoon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            selected = index + 1;
                            ratingCount++;
                            if (ratingCount > 0) {
                              avgRating =
                                  (((ratingCount - 1) * avgRating) + selected) /
                                      ratingCount;
                            } else {
                              avgRating = selected.toDouble();
                            }
                          });
                          _saveRating();
                        },
                        icon: Icon(
                          index < selected
                              ? Icons.star
                              : Icons.star_border_outlined,
                          color: Colors.amber,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Average Rating : ${avgRating.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "($ratingCount Ratings)",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  if (isFav == false) {
                    widget.f.fav_add(widget.wc);
                  }
                  if (isFav == true) {
                    widget.f.fav_rem(widget.wc);
                  }
                  isFav == false
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${widget.wc.title} is added to Favourite"),
                            duration: Duration(seconds: 1),
                            action: SnackBarAction(
                                label: "Undo",
                                onPressed: () {
                                  widget.f.fav_rem(widget.wc);
                                  setState(() {
                                    isFav = widget.f.isFavorite(widget.wc);
                                  });
                                }),
                          ),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${widget.wc.title} is removed from favourites"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                  setState(() {
                    isFav = widget.f.isFavorite(widget.wc);
                  });
                },
                child: Container(
                  height: isFav == false ? 50 : 55,
                  width: isFav == false ? 300 : 330,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: isFav == false ? 6 : 10,
                        ),
                        Text(
                          isFav == false
                              ? "Add to Favourite"
                              : "Remove From favourite",
                          style: TextStyle(
                            fontSize: isFav == false ? 18 : 22,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
