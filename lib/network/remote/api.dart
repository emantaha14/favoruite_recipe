import 'dart:convert';

import 'package:http/http.dart';

import '../../models/recipe_information_model.dart';
import '../../models/recipes-model.dart';
const String baseUrl = 'https://api.spoonacular.com';
class API{

  static Future<RecipesModel>getALlRecipes()async{
    Uri url = Uri.parse('$baseUrl/recipes/complexSearch?apiKey=e959c112307f460f9d7ae5c7014bfd3c');
    print('Eman1');
    Response response = await get(url);
    print('Eman2');
    print("eman ============ ${response.body.toString()}");
    if(response.statusCode == 200){
      final returnedData = json.decode(response.body);
      return RecipesModel.fromJson(returnedData);
    }
    else {
      throw Exception('ERROR alll ======================');
    }

  }

  static Future<RecipesInformationModel>getAllRecipesInformation(int id)async{
     Uri url = Uri.parse('$baseUrl/recipes/$id/information?includeNutrition=false&apiKey=e959c112307f460f9d7ae5c7014bfd3c');
     Response response = await get(url);
     if(response.statusCode == 200){
       final returnedData = json.decode(response.body);
       return RecipesInformationModel.fromJson(returnedData);
     }
     else {
       throw Exception('ERROR information =============');
     }
  }

}
