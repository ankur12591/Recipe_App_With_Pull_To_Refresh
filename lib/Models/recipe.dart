class Recipe {
  String label;
  String source;
  String url;
  String imgurl;

  Recipe({this.label, this.url, this.imgurl, this.source});

  factory Recipe.fromMap(Map<String,dynamic> parsedJson){
    return Recipe(
        label: parsedJson["label"] ,
        url: parsedJson["url"],
        imgurl: parsedJson["image"],
        source: parsedJson["source"] );
  }
}