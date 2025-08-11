
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical MCQ Quiz',
      home: const QuizWebView(),
    );
  }
}

class QuizWebView extends StatefulWidget {
  const QuizWebView({super.key});
  @override
  State<QuizWebView> createState() => _QuizWebViewState();
}

class _QuizWebViewState extends State<QuizWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    String fileHtmlContents = await rootBundle.loadString('assets/index.html');
    _controller.loadHtmlString(fileHtmlContents, baseUrl: 'assets/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
