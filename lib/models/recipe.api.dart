
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:visualstudio_test/models/recipe.dart';

// const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
// 	limit: '24',
// 	start: '0'
// });

// req.headers({
// 	'X-RapidAPI-Key': 'cb24f2f391msh9f991ec16d0f3c1p19dbe8jsn0e52ed227be8',
// 	'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
// });

// req.end(function (res) {
// 	if (res.error) throw new Error(res.error);
 
// 	console.log(res.body);
// });
class RecipeApi {

  // static Future<List<Recipe>> getRecipe() async{
  //   var  uri = Uri.http('yummly2.p.rapidapi.com','/feeds/list',{
	// 'limit': '24',
	// 'start': '0'

  //   });
  //   final response =  await http.get(uri,headers: {
  //   	'X-RapidAPI-Key': 'cb24f2f391msh9f991ec16d0f3c1p19dbe8jsn0e52ed227be8',
	//     'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
  //   });
  //    Map data = jsonDecode(response.body); 
  //    List _temp  = [];
  //      for ( var i in data['feed']){
  //       _temp.add(i['content']['details']);
  //      }
  //      return Recipe.recipesFromSnapshot(_temp);

  // }

   
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: { 
      "x-rapidapi-key": "cb24f2f391msh9f991ec16d0f3c1p19dbe8jsn0e52ed227be8",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _temp = [];

      if (data['feed'] != null) {
        for (var i in data['feed']) {
          _temp.add(i['content']['details']);
        }
      } else {
        print('Feed data is null or not iterable');
      }

      return Recipe.recipesFromSnapshot(_temp);
    } else {
      print('Request failed with status: ${response.statusCode}');
      return []; // Return an empty list or handle the error accordingly
    }
  }
}