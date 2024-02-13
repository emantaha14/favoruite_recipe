class RecipesModel {
  final List<Recipe> recipes;

  RecipesModel({
    required this.recipes,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
    recipes: List<Recipe>.from(json["results"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(recipes.map((x) => x.toJson())),
  };
}

class Recipe {
  final int id;
  final String title;
  final String image;


  Recipe({
    required this.id,
    required this.title,
    required this.image,
  });


  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(

    id: json["id"],
    title: json["title"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}

class ExtendedIngredient {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalName;
  final double amount;
  final String unit;
  final List<String> meta;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
  });



  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) => ExtendedIngredient(
    id: json["id"],
    aisle: json["aisle"],
    image: json["image"],
    consistency: json["consistency"],
    name: json["name"],
    nameClean: json["nameClean"],
    original: json["original"],
    originalName: json["originalName"],
    amount: json["amount"]?.toDouble(),
    unit: json["unit"],
    meta: List<String>.from(json["meta"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "aisle": aisle,
    "image": image,
    "consistency": consistency,
    "name": name,
    "nameClean": nameClean,
    "original": original,
    "originalName": originalName,
    "amount": amount,
    "unit": unit,
    "meta": List<dynamic>.from(meta.map((x) => x)),
  };
}



