import 'package:flutter/material.dart';
import 'package:wallpaper_josequel/controllers/search_controller.dart';
import 'custom/widgets/wallpaper_widget.dart';

class SearchView extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return
   query!=""?  FutureBuilder(
      future: query== "" ? SearchWallpaper().getSearchWallpaper():SearchWallpaper().getSearchWallpaper(searchQuery: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return WallpaperWidget(snapshot);
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text("No Data Found, Please try again later"),
          );
        }
        return Container();
      },
    ):Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search Wallpapers'),);
  }
}
