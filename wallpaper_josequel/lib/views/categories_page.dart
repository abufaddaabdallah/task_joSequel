import 'package:flutter/material.dart';
import 'package:wallpaper_josequel/controllers/categories_controller.dart';
import 'package:wallpaper_josequel/models/wallpaper.dart';
import 'package:wallpaper_josequel/providers/wallpaper_provider.dart';
import 'package:wallpaper_josequel/views/custom/widgets/wallpaper_widget.dart';

class CategoriesScreen extends StatefulWidget {
    final String categories;

  const CategoriesScreen({super.key, required this.categories});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Wallpaper> photos = [];
WallPaperProvider wallPaperProvider = WallPaperProvider();
   @override
  void initState() {
    super.initState();
    wallPaperProvider.categories=widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("brandName()"),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: CategoriesController().getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return WallpaperWidget(snapshot);
                }
                if(snapshot.connectionState == ConnectionState.none){
                  return const Center(child: Text("No Data Found, Please try again later"),);
                }
                return Container();
              },
            ),
          ],
        )
        ,
      ),
    );
  }
}