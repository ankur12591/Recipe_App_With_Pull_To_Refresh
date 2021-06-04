import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/Screens/recipe_tile.dart';
import 'package:recipe_app/secret.dart';
import 'dart:core';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// TextEditingController _textEditingController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey;

  String ingredient;
  bool _loading = false;

// ignore: deprecated_member_use
  List<Recipe> recipes = [];

  getRecipes() async {
    setState(() {
      _loading = true;
    });

    var recipeData = await http.get(Uri.parse(
        "https://api.edamam.com/search?q=$ingredient&app_id=$appId&app_key=$appKey"));

    Map<String, dynamic> jsonData = await jsonDecode(recipeData.body);
    print(jsonData);

    jsonData["hits"].forEach((recipeInfo) {
      Recipe recipe = Recipe();

      Map<String, dynamic> recipeInfo2 = recipeInfo["recipe"];

      recipe = Recipe(
          label: recipeInfo2["label"],
          url: recipeInfo2["url"],
          imgurl: recipeInfo2["image"],
          source: recipeInfo2["source"]);

      // recipe = Recipe.fromMap(recipeInfo["recipe"]);
      recipes.add(recipe);
    });

    setState(() {
      _loading = false;
    });
  }

  Future<void> _getSearchData() async {
    setState(() {
      getRecipes();
    });
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    //_getSearchData();
  }

  // This method will run when widget is unmounting
  @override
  void dispose() {
    // disposing states
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 2),
              () {
                // adding elements in list after [1 seconds] delay
                // to mimic network call

                setState(() {
                  getRecipes();
                });

                // showing snackbar
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: const Text('Page Refreshed'),
                  ),
                );
              },
            );
          },
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // color: Color(0xffF5F0E6),
                    //color: Color(0xffEEEFF2),
                    // color: Color(0xFFFDE0D9),
                    //   color: Color(0xFFF8F8FF),
                    //  color: Color(0xFFFBF9FA),
                    color: Color(0xFFF8F5F3)),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 24),
                            Text(
                              "Recipe",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2C384A),
//                                  color: Color(0xff03071e),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "App",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Made by  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontWeight: FontWeight.w300
                            ),
                          ),
                          Text(
                            "Ankur Sutariya",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "What will you cook today?",
                        style: TextStyle(
                            color: Color(0xFF2C384A),
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 14),
                      Text(
                        "Just Enter Ingredients you have and we will show the best recipe for you",
                        style: TextStyle(
                            color: Color(0xFF2C384A),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                // controller: _textEditingController,
                                onChanged: (value) => {ingredient = value},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabled: true,
                                  hintText: "Enter Ingridients",
                                ),
                                style: TextStyle(
                                  color: Color(0xFF2C384A),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (ingredient != null) {
                                  recipes = [];
                                  getRecipes();
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.brown[200],
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Icon(Icons.search)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(25)),
                        child: _loading
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height - 350,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : Container(
                                //margin: EdgeInsets.only(top: 10),
                                //padding: EdgeInsets.all(10),
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(25)),
                                child: recipeView()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget recipeView() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) => RecipeTile(
        label: recipes[index].label,
        url: recipes[index].url,
        imgUrl: recipes[index].imgurl,
        source: recipes[index].source,
      ),
    );
  }
}
