import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_josequel/providers/wallpaper_provider.dart';

import 'image_view.dart';

class WallpaperFavoritesScreen extends StatelessWidget {
  const WallpaperFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<WallPaperProvider>(context);
    final favoritePhotos = favoritesProvider.favorites;
print(favoritePhotos);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Photos'),
        elevation: 0,
      ),
      body:favoritePhotos.isEmpty?Container():
       GridView.builder(
      itemCount: favoritePhotos.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(4.0),
      itemBuilder: (context, index) {
        final photo = favoritePhotos[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageView(
                  imgPath: photo.src!.portrait!, wallpaper: photo,
                ),
              ),
            );
          },
          child: GridTile(
              child: Stack(
                children: [
                  Hero(
                    tag: photo.src!.portrait!,
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: kIsWeb
                              ? Image.network(
                            photo.src!.portrait!,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                              : CachedNetworkImage(
                              imageUrl: photo.src!.portrait!,
                              placeholder: (context, url) =>
                                  Container(
                                    color: const Color(0xfff5f8fd),
                                  ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle,color: Colors.red,),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(photo);
                    },
                  ),
                ],
              ),),
        );
      },
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
      ),
    ),
    );
  }
}