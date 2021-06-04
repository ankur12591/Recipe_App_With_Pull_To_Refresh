import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/recipe_view.dart';

 //import 'package:recipe_app/Screens/new_recipe_view.dart';


class RecipeTile extends StatelessWidget {
  final String label;
  final String url;
  final String imgUrl;
  final String source;

  RecipeTile({this.label,this.url,this.imgUrl,this.source});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(url: url)));
      },
      child: Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadiusDirectional.circular(10)
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(source,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
