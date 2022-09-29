import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/maintenance_dialog.dart';
import 'package:labo_flutter/components/update_dialog.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/pages/home/home_page.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page.dart';
import 'package:labo_flutter/utils/app_themes.dart';
import 'package:labo_flutter/utils/remote_config_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

const graphqlEndpoint = 'https://labo-flutter.hasura.app/v1/graphql';

Future<void> main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.initialize();
  // ローカルエミュレータを使用する場合の設定
  // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  final analytics = FirebaseAnalytics();

  // GraphQL
  await initHiveForFlutter();

  // timeago
  timeago.setLocaleMessages('ja', timeago.JaMessages());

  runApp(
    ProviderScope(
      child: MyApp(
        analytics: analytics,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    return GraphQLApiClient(
      uri: graphqlEndpoint,
      child: MaterialApp(
        title: 'MaterialApp',
        theme: AppThemes().lightTheme,
        darkTheme: AppThemes().darkTheme,
        home: RootView(
          analytics: analytics,
        ),
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
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int currentIndex = 0;
  final List<Widget> childViews = [
    const HomePage(),
    const MyProfilePage(),
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
    setCurrentScreen(index: index);
  }

  Future<void> setCurrentScreen({required int index}) async {
    final screenName = (index == 0) ? 'HomePage' : 'MyProfilePage';
    await widget.analytics.setCurrentScreen(screenName: screenName);
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await showUpdateDialogIfNeeded(context);
      await showMaintenanceDialogIfNeeded(context);
    });
    setCurrentScreen(index: 0);
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
