import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({required this.blogUrl, Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  double _loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    // Force HTTPS if HTTP is provided
    String url = widget.blogUrl.startsWith("http:")
        ? widget.blogUrl.replaceFirst("http:", "https:")
        : widget.blogUrl.startsWith("https:")
        ? widget.blogUrl
        : 'https://${widget.blogUrl}';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Widget _buildErrorView(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load article',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your internet connection',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _controller.reload(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: _loadingProgress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: _loadingProgress < 0 ? null : _loadingProgress,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading article... ${(_loadingProgress * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("InBrief"),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _hasError = false;
                _isLoading = true;
              });
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) _buildLoadingView(context),
          if (_hasError) _buildErrorView(context),
        ],
      ),
    );
  }
}