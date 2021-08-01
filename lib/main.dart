import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/views/home_view.dart';
import 'package:labo_flutter/views/my_page_view.dart';
import 'package:labo_flutter/views/playground_view.dart';

const graphqlEndpoint = 'https://api.spacex.land/graphql/';

Future main() async {
  await dotenv.load(fileName: '.env');

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userCredential = await FirebaseAuth.instance.signInAnonymously();
  print('userCredential: $userCredential');

  // GraphQL
  await initHiveForFlutter();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLApiClient(
      uri: graphqlEndpoint,
      child: MaterialApp(
        title: 'MaterialApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RootView(title: 'RootView'),
      ),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int currentIndex = 0;
  final List<Widget> childViews = [
    const HomeView(),
    const PlaygroundView(title: 'PlaygroundView', color: Colors.redAccent),
    const MyPageView(),
  ];

  final List<BottomNavigationBarItem> navigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'ホーム',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      label: 'Playground',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'マイページ',
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaboFlutter'),
        backgroundColor: Colors.blue,
      ),
      body: childViews[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: navigationBarItems,
      ),
    );
  }
}
