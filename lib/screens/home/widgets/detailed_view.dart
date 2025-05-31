import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailViewScreen extends StatefulWidget {
  final String newsUrl;

  DetailViewScreen({super.key, required this.newsUrl});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    String url = widget.newsUrl.startsWith("http:")
        ? widget.newsUrl.replaceFirst("http:", "https:")
        : widget.newsUrl;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..setBackgroundColor(Colors.transparent) // Adaptive background
      ..loadRequest(Uri.parse(url)); // Load the page
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("InBrief"),
        backgroundColor: theme.scaffoldBackgroundColor, // Adaptive AppBar color
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black, // Visible back icon
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
