import 'package:flutter/material.dart';

import '../controllers/db_helper.dart';
import '../models/wallpaper.dart';

class WallPaperProvider with ChangeNotifier {
  String categories = "";
  TextEditingController searchController = TextEditingController();
   List<Wallpaper> _favorites = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Wallpaper> get favorites => _favorites;

  Future<void> loadFavoritesFromDatabase() async {
    final favoriteRecords = await _databaseHelper.queryAll();
    _favorites = favoriteRecords.map((record) {
      return Wallpaper(
        id: record[DatabaseHelper.columnId],
        url: record[DatabaseHelper.columnImageUrl],
        isFavorite: true,
      );
    }).toList();
    notifyListeners();
  }
  void toggleFavorite(Wallpaper photo) async {
    photo.isFavorite = !photo.isFavorite!;
    if (photo.isFavorite!) {
      _favorites.add(photo);
      await _databaseHelper.insert({
        DatabaseHelper.columnName: photo.id,
        DatabaseHelper.columnImageUrl: photo.url,
      });
    } else {
      _favorites.remove(photo);
      await _databaseHelper.delete(photo.id!);
    }
    notifyListeners();
  }
}
