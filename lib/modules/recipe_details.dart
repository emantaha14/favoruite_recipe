import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../network/local/recipe_dp.dart';
import '../network/remote/api.dart';

class RecipeDetails extends StatefulWidget {
   final int id;
   final String title;
   final String photo;
   const RecipeDetails({super.key,required this.id,required this.title, required this.photo});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  int counter =0;
  int colorChange = 0;
  SqlDb sqlDb =  SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM favouriteRecipes WHERE fakeId = ${widget.id}');
    print(response);
    return response;
  }
  @override

  void initState() {
    readData().then((value) {
      setState(() {
        colorChange = value.isEmpty?0:1;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            if (colorChange == 0){
              setState(() {
                colorChange = 1;
              });
              int response = await sqlDb.insertData('INSERT INTO favouriteRecipes(title, photo, fakeId) VALUES("${widget.title}", "${widget.photo}", "${widget.id}")');
              if(response > 0){
                print('$response======================');
              }
            }
            else if(colorChange == 1){
              int response = await sqlDb.deleteData("DELETE FROM favouriteRecipes WHERE fakeId = ${widget.id} ");
              if(response > 0){
                print('$response======================');
              }
              setState(() {colorChange =0;});
            }

          }, icon: const Icon(Icons.favorite),color: colorChange == 1? Colors.red : Colors.grey,)
        ],
      ),
      body: FutureBuilder(
        future: API.getAllRecipesInformation(widget.id),
        builder:(context, snapshot)
        {
          if(snapshot.hasData){
            return ListView(
              children: [
                Image.network(snapshot.data!.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,),
               Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(snapshot.data!.title,
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 30
                         ),),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(snapshot.data!.summary,
                         style: const TextStyle(
                           fontWeight: FontWeight.w400,
                           fontSize: 14,
                         ),
                         maxLines: 10,),
                     ),
                     Card(
                         child : Row(
                           children: [
                             Text('$counter Serving',
                             style: TextStyle(
                               fontWeight: FontWeight.bold
                             ),),
                             Spacer(),
                             Container(
                               decoration: BoxDecoration(
                                   border:Border.all(color: Colors.green)
                               ),
                               child: InkWell(
                                 onTap: (){
                                   counter++;
                                   setState(() {});
                                 },
                                 child: const Icon(Icons.add),
                               ),
                             ),
                             const SizedBox(width: 20,),

                             Container(
                               decoration: BoxDecoration(
                                   border:Border.all(color: Colors.green)
                               ),
                               child: InkWell(
                                 onTap: (){
                                   counter--;
                                   setState(() {});
                                 },
                                 child: const Icon(Icons.minimize,),
                               ),),
                           ],
                         )
                     ),
                      SizedBox(height: 10,),
                     Card(
                         child:
                         Row(
                           children: [
                             Text('Ingredient\'s',
                               style: TextStyle(
                                 fontSize: 25,
                                 color: Colors.green[700],
                               ),),
                             const Spacer(),
                             Container(
                               height: 30,
                               width: 135,
                               decoration: BoxDecoration(
                                   border:Border.all(color: Colors.green,)
                               ),
                               child: InkWell(
                                   child: Center(child: Text('Add to carocery list')),
                                   onTap: (){}),
                             )

                           ],
                         )
                     )
                   ],
                 ),
               )

              ],
            );
          }
          else if(snapshot.hasError){
            throw Exception('Error: ${snapshot.error}');
          }
         return const Center(
           child: CircularProgressIndicator(),
         );
        },
      ),
    );
  }
}
