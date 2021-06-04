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
      appBar: AppBar(
        backgroundColor: Color(0xff355070),
        // title: Text("${widget.category} News"),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Recipe",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
            ),
            Opacity(opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save),
              ),
            ),
          ],
        ),
      ),

      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.url,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },

        ),
      ),
    );
  }
}
