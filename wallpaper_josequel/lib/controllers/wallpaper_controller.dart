import 'package:wallpaper_josequel/models/wallpaper.dart';

import 'api_helper.dart';

class WallpaperController {
  Future<List<Wallpaper>> getAll() async {
    try {
      List<Wallpaper> wallpapers = [];
      Map<String, dynamic>  response = await ApiHelper().getRequest(path: '/v1/curated',queryParameters: {
              "per_page": 30.toString(),
              "page": "1"
            });
        print(response);
      response["photos"].forEach((v) {
        wallpapers.add(Wallpaper.fromJson(v));
      });

      return wallpapers;
    } catch (ex) {
      rethrow;
    }
  }
}
//iDQlOQE0FQzfChLM2bQ4w1PZQgI9GCHMouFRIJuh2lYzhDS5es5bmNNe
