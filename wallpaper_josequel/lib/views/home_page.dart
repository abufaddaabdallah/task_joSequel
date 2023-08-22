import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_josequel/controllers/wallpaper_controller.dart';
import 'package:wallpaper_josequel/models/wallpaper.dart';
import 'package:wallpaper_josequel/views/custom/widgets/title_widget.dart';
import 'package:wallpaper_josequel/views/search_page.dart';
import 'package:wallpaper_josequel/views/wallpaper_favorites_page.dart';

import 'custom/widgets/wallpaper_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wallpaper> photos = [];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchView());
            },
          ),
        ),
        title: brandName(),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WallpaperFavoritesScreen(),
              ),
            ),
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Made By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL(
                          "https://www.linkedin.com/in/abdallah-abufadda/");
                    },
                    child: const Text(
                      "Abdallah AbuFadda",
                      style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontFamily: 'Overpass'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                future: WallpaperController().getAll(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
