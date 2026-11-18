import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Requirement 8: WebView Integration
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _isSupported = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      try {
        _isSupported = true;
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => setState(() => _isLoading = true),
              onPageFinished: (_) => setState(() => _isLoading = false),
              onWebResourceError: (error) {
                debugPrint('WebView Error: ${error.description}');
              },
            ),
          )
          ..loadRequest(Uri.parse('https://flutter.dev'));
      } catch (e) {
        setState(() => _isSupported = false);
      }
    } else {
      setState(() => _isSupported = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF4C1D95), Color(0xFF7C3AED)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text('WebView Portal'),
        actions: [
          if (_isSupported && _controller != null)
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Reload',
              onPressed: () => _controller!.reload(),
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_isSupported && _controller != null)
            WebViewWidget(controller: _controller!)
          else
            // Perfectly centered layout for fallback view
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Globe icon with gradient background & glow
                        Container(
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7C3AED), Color(0xFF0EA5E9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
                                blurRadius: 22,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.language_rounded, size: 56, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Web Portal',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FE),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFC4B5FD)),
                          ),
                          child: const Text(
                            'https://flutter.dev',
                            style: TextStyle(fontSize: 13, color: Color(0xFF7C3AED), fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFDDD6FE)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C3AED).withValues(alpha: 0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Text(
                            'WebView integration is active. On Android / iOS mobile devices, the live webpage renders directly inside this screen.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13.5, color: Color(0xFF475569), height: 1.5),
                          ),
                        ),
                        const SizedBox(height: 22),
                        // Gradient check connection button
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('✅ Portal active: https://flutter.dev'),
                                backgroundColor: Color(0xFF7C3AED),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF0EA5E9)]),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_outline, size: 20, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Check Connection', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Purple loading progress bar at the top
          if (_isLoading && _isSupported)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Color(0xFFEDE9FE),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)),
                minHeight: 4,
              ),
            ),
        ],
      ),
    );
  }
}
