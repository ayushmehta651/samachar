import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  final String data;
  const WebScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 75.0),
              child: Text(
                "News",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: WebView(
        debuggingEnabled: false,
        gestureNavigationEnabled: false,
        initialUrl: data,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}