import 'package:favoruite_recipe/modules/recipe_details.dart';
import 'package:favoruite_recipe/network/local/recipe_dp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/remote/api.dart';
import 'add_favourite_recipes.dart';

class RecipsList extends StatefulWidget {
  const RecipsList({super.key});

  @override
  State<RecipsList> createState() => _RecipsListState();
}

class _RecipsListState extends State<RecipsList> {
  int currentIndex = 0;
  SqlDb sqlDb = SqlDb();
  List<Widget> pages = [const RecipesScreen(), const AddFavouriteRecipes()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          currentIndex == 0?'RECIPES LIST':'Favourite Recipes',
          style: TextStyle(
            color: Colors.green[700],
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.notes,),
          color:Colors.green[700],
          iconSize: 30,
          onPressed: (){
            sqlDb.onDeleteDataBase();
          },
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.green[700],
        items: [
          BottomNavigationBarItem(label: 'recipes',icon: Icon(Icons.home),),
          BottomNavigationBarItem(label: 'favourites',icon: Icon(Icons.favorite)),
        ],
      ),
      body: pages.elementAt(currentIndex),
    );
  }
}
class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
          future: API.getALlRecipes(),
          builder:(context, snapshot) {
            if(snapshot.hasData){
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                itemCount: snapshot.data!.recipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  RecipeDetails(id: snapshot.data!.recipes[index].id,
                            title: snapshot.data!.recipes[index].title,
                            photo: snapshot.data!.recipes[index].image),));
                        print(snapshot.data!.recipes[index].id);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data!.recipes[index].image), // Replace with your image path
                                fit: BoxFit.fill, // Adjust BoxFit according to your needs
                              ),
                            ),
                          ),
                          Center(child: Text(snapshot.data!.recipes[index].title,maxLines: 2,)),
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
