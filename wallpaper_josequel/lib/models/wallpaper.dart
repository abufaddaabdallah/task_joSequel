class Wallpaper{
  int? id;
    String? url;
    String? photographer;
    String? photographerUrl;
    int? photographerId;
    SrcModel? src;
    bool? isFavorite;

    Wallpaper(
        {this.id,
          this.url,
            this.photographer,
            this.photographerId,
            this.photographerUrl,
            this.src,
        this.isFavorite=false
        });

    factory Wallpaper.fromJson(Map<String, dynamic> parsedJson) {
        return Wallpaper(
            id: parsedJson["id"],
            url: parsedJson["url"],
            photographer: parsedJson["photographer"],
            photographerId: parsedJson["photographer_id"],
            photographerUrl: parsedJson["photographer_url"],
            src: SrcModel.fromJson(parsedJson["src"]));
    }
}

class SrcModel {
    String? portrait;
    String? large;
    String? landscape;
    String? medium;

    SrcModel({this.portrait, this.landscape, this.large, this.medium});

   factory  SrcModel.fromJson(Map<String, dynamic> srcJson) {
       return  SrcModel(
            portrait: srcJson["portrait"],
            large: srcJson["large"],
            landscape: srcJson["landscape"],
            medium: srcJson["medium"]);
    }
}