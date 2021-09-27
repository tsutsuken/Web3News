import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/utils/app_themes.dart';
import 'package:labo_flutter/views/home_view.dart';
import 'package:labo_flutter/views/my_page_view/my_page_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

const graphqlEndpoint = 'https://labo-flutter.hasura.app/v1/graphql';

Future main() async {
  await dotenv.load(fileName: '.env');

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // GraphQL
  await initHiveForFlutter();

  // timeago
  timeago.setLocaleMessages('ja', timeago.JaMessages());

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
        theme: AppThemes().lightTheme,
        darkTheme: AppThemes().darkTheme,
        home: const RootView(),
        builder: EasyLoading.init(),
        localizationsDelegates: const [
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          return locale;
        },
      ),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int currentIndex = 0;
  final List<Widget> childViews = [
    const HomeView(),
    const MyPageView(),
  ];

  final List<BottomNavigationBarItem> navigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'ホーム',
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
      body: IndexedStack(
        index: currentIndex,
        children: childViews,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: navigationBarItems,
      ),
    );
  }
}
