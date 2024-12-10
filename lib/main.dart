import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // フルスクリーンに近いボトムシートの場合
      builder: (context) => BottomSheetNavigator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context),
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

class BottomSheetNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8, // 高さを調整
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            // 初期画面のルートを設定
            return MaterialPageRoute(
              builder: (context) => BottomSheetHomePage(),
            );
          },
        ),
      ),
    );
  }
}

class BottomSheetHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Bottom Sheet Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // ボトムシート全体を閉じる
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BottomSheetSecondPage(),
              ),
            );
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class BottomSheetSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Second Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: Text('This is the second page in the bottom sheet.'),
      ),
    );
  }
}
