import 'dart:html';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final blogUrl;
  const ArticleView({this.blogUrl});
  @override
  _State createState()=>_State();
}
class _State extends State<ArticleView> {
  final controller=WebViewController();
  final Completer<WebViewController> _completer=Completer<WebViewController>();
  @override
  Widget build(BuildContext context){
    return Container(
      child:WebViewWidget(
        controller: controller,
        
      ),
    );
  }
}