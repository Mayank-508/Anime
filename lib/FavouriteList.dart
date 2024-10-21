import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/WebtoonCategory.dart';
import 'package:untitled2/webtoons.dart';

class Favourite {
  List<WebtoonCategory> fav_list = [];

  Future<void> saveFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favTitles = fav_list.map((webtoon) => webtoon.title).toList();
    await prefs.setStringList('Fav', favTitles);
  }

  Future<void> loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favTitles = prefs.getStringList('Fav');
    if (favTitles != null) {
      fav_list = category
          .where((webtoon) => favTitles.contains(webtoon.title))
          .toList();
    }
  }

  void fav_add(WebtoonCategory w) {
    fav_list.add(w);
    saveFavourites();
  }

  void fav_rem(WebtoonCategory w) {
    fav_list.remove(w);
    saveFavourites();
  }

  bool isFavorite(WebtoonCategory w) {
    return fav_list.contains(w);
  }
}
