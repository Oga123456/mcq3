import 'dart:convert';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical MCQ Quiz',
      home: QuizWebView(),
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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent);

    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    String htmlContent = await rootBundle.loadString('assets/index.html');
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(htmlContent));
    await _controller.loadRequest(
      Uri.parse('data:text/html;base64,$contentBase64'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
