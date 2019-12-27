import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewYouTube extends StatefulWidget {
  @override
  _WebViewYouTubeState createState() => _WebViewYouTubeState();
}

class _WebViewYouTubeState extends State<WebViewYouTube> {
  // Field

  // Method
  Widget showWebView() {
    String url = 'https://youtu.be/O5-WI7XN6uo';

    return WebviewScaffold(
      url: url,
      withJavascript: true,
      withZoom: true,
      hidden: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: Container(child: showWebView(),),
    );
  }
}
