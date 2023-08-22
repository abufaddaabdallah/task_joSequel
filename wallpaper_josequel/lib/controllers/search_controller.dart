import '../models/wallpaper.dart';
import 'api_helper.dart';

class SearchWallpaper{
  Future<List<Wallpaper>> getSearchWallpaper({String? searchQuery}) async {
print(searchQuery);
List<Wallpaper> wallpapers = [];
    try {
      if(searchQuery!=null){
        Map<String, dynamic>  response = await ApiHelper().getRequest(path: '/v1/search',queryParameters: {
          "per_page": 30.toString(),
          "page": "1",
          "query": searchQuery.toString(),
        });
        print(response);
        response["photos"].forEach((v) {
          wallpapers.add(Wallpaper.fromJson(v));
        });
      }
      return wallpapers;
    } catch (ex) {
      rethrow;
    }
  }
}