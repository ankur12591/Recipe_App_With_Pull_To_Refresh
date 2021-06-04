import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class RecipeView extends StatefulWidget {
  final String url;
  RecipeView({@required this.url});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
          children : [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 24),
                  Text(
                    "Recipe",
                    style: TextStyle(fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "App",
                    style: TextStyle(fontSize: 22,
                        color: Colors.pink,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),

            SizedBox(height: 14),



            Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl:  widget.url,
              onWebViewCreated: (WebViewController webViewController){
                _controller.complete(webViewController);
              },
            ),
          ),
          ]
      )
    );
  }
}
