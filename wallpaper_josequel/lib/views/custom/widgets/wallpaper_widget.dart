import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/wallpaper.dart';
import '../../image_view.dart';

GridView WallpaperWidget(AsyncSnapshot<List<Wallpaper>> snapshot) {
  return GridView.builder(
    itemCount: snapshot.data!.length,
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    padding: const EdgeInsets.all(4.0),
    itemBuilder: (context, index) {
      Wallpaper wallpapers = snapshot.data![index];
      return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgPath: wallpapers.src!.portrait!, wallpaper: wallpapers,
                    
                  ),
                ),
              );
            },
            child: Hero(
              tag: wallpapers.src!.portrait!,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: kIsWeb
                      ? Image.network(
                    wallpapers.src!.portrait!,
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                      : CachedNetworkImage(
                      imageUrl: wallpapers.src!.portrait!,
                      placeholder: (context, url) =>
                          Container(
                            color: const Color(0xfff5f8fd),
                          ),
                      fit: BoxFit.cover)),
            ),
          ));
    },
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
    ),
  );
}
