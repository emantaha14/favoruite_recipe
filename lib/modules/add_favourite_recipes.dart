import 'package:favoruite_recipe/modules/recipe_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/local/recipe_dp.dart';


class AddFavouriteRecipes extends StatefulWidget {
  const AddFavouriteRecipes({super.key});

  @override
  State<AddFavouriteRecipes> createState() => _AddFavouriteRecipesState();
}

class _AddFavouriteRecipesState extends State<AddFavouriteRecipes> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM favouriteRecipes');
    print(response);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: readData(),
            builder:(context, snapshot) {
              if(snapshot.hasData){
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  RecipeDetails(
                              id: snapshot.data![index]['fakeId'],
                              title: snapshot.data![index]['title'],
                              photo: snapshot.data![index]['photo']),));
                          print(snapshot.data![index]['fakeId']);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data![index]['photo']), // Replace with your image path
                                  fit: BoxFit.fill, // Adjust BoxFit according to your needs
                                ),
                              ),
                            ),
                            Center(child: Text(snapshot.data![index]['title'],maxLines: 2,)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              else if (snapshot.hasError){
                throw Exception(
                    'Error is :${snapshot.error}'
                );
              }
              else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        ),

    );
  }
}
