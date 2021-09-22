import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:labo_flutter/views/edit_profile_view.dart';
import 'package:labo_flutter/views/setting_view.dart';
import 'package:labo_flutter/views/sign_in_view.dart';
import 'package:labo_flutter/views/sign_up_view.dart';

const String myUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
    profile_image_url
  }
}
''';

const String myCommentsQuery = '''
  query MyQuery(\$user_id: String!) {
    comments(where: {user_id: {_eq: \$user_id}}) {
      id
      created_at
      text
      user_id
      article_id
    }
  }
''';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'コメント'),
    Tab(text: 'お気に入り'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return _ScaffoldWidget(tabController: _tabController, tabs: tabs);
  }
}

class _ScaffoldWidget extends HookWidget {
  const _ScaffoldWidget({
    Key? key,
    required TabController tabController,
    required this.tabs,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final _userChangeNotifier = useProvider(userChangeNotifierProvider);

    return Scaffold(
      body: _userChangeNotifier.currentUser == null
          ? _buildNotLoggedInWidget(context)
          : _buildLoggedInWidget(context, _userChangeNotifier),
    );
  }

  Widget _buildNotLoggedInWidget(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.person,
            size: 80,
          ),
          Text(
            '保存した記事を閲覧',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors().textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SignUpView()),
                );
              },
              child: const Text(
                '新規登録',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SignInView()),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: const Text(
                'ログイン',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInWidget(
      BuildContext context, UserChangeNotifier _userChangeNotifier) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context, _userChangeNotifier),
        _buildMyCommentsQuery(_userChangeNotifier)
      ],
    );
  }

  SliverAppBar _buildSliverAppBar(
      BuildContext context, UserChangeNotifier _userChangeNotifier) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 280,
      toolbarHeight: 56,
      title: const Text('マイページ'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SettingView()));
            },
            icon: const Icon(Icons.settings))
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Container(
          child: _buildBarContent(context, _userChangeNotifier.currentUser),
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: tabs,
      ),
    );
  }

  Query _buildMyCommentsQuery(UserChangeNotifier _userChangeNotifier) {
    return Query(
      options: QueryOptions(
        document: gql(myCommentsQuery),
        variables: <String, dynamic>{
          'user_id': _userChangeNotifier.currentUser?.uid ?? '',
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return SliverToBoxAdapter(child: Text(result.exception.toString()));
        }

        if (result.isLoading) {
          return const SliverToBoxAdapter(child: Text('Loading'));
        }

        var comments = <Comment>[];
        final resultData = result.data;
        if (resultData != null) {
          comments = CommentListResponse.fromJson(resultData).comments;
        }

        return _buildSliverList(comments);
      },
    );
  }

  SliverList _buildSliverList(List<Comment> comments) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final comment = comments[index];
        return ListTile(
          title: Text(
            comment.text,
            style: TextStyle(color: AppColors().textPrimary),
          ),
          trailing: const Icon(Icons.more_vert),
          subtitle: Text(
            comment.articleId,
            style: TextStyle(color: AppColors().textSecondary),
          ),
          onTap: () {},
        );
      }, childCount: comments.length),
    );
  }

  Widget _buildBarContent(BuildContext context, User? currentUser) {
    return SizedBox(
        width: double.infinity,
        height: 192,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMyUserQuery(currentUser),
            SizedBox(
              height: 36,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const EditProfileView(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Text('プロフィールを編集',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
              ),
            ),
          ],
        )));
  }

  Query _buildMyUserQuery(User? currentUser) {
    return Query(
      options: QueryOptions(
        document: gql(myUserQuery),
        variables: <String, dynamic>{
          'id': currentUser?.uid ?? '',
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Text('Loading');
        }

        final resultData = result.data?['users_by_pk'] as Map<String, dynamic>?;
        if (resultData == null) {
          return const Text('No User');
        }
        final appUser = AppUser.fromJson(resultData);
        return _buildUserInfoContainer(appUser);
      },
    );
  }

  Widget _buildUserInfoContainer(AppUser appUser) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: NetworkImage(appUser.profileImageUrl)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          appUser.name,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
