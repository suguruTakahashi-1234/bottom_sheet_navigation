import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

/// メインアプリ用 GoRouter
final GoRouter mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);

final GoRouter bottomSheetRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => BottomSheetHomePage(),
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => BottomSheetSecondPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: mainRouter, // メインアプリ用 GoRouter
    );
  }
}

class HomePage extends StatelessWidget {
  void _showBottomSheet(BuildContext context) {
    // ボトムシートを開く前にルートをリセット
    bottomSheetRouter.go('/home');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            child: MaterialApp.router(
              routerConfig: bottomSheetRouter,
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context),
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

/// ボトムシートの最初のページ
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
              Navigator.of(context, rootNavigator: true).pop(); // ボトムシート全体を閉じる
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/second'); // ボトムシート内での遷移
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
        automaticallyImplyLeading: true,
        title: Text('Second Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); // ボトムシート全体を閉じる
            },
          ),
        ],
      ),
      body: Center(
        child: Text('This is the second page in the bottom sheet.'),
      ),
    );
  }
}
