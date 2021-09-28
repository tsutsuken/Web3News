import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/components/comment_list_item.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/pages/edit_profile_page.dart';
import 'package:labo_flutter/pages/setting_page.dart';
import 'package:labo_flutter/utils/app_colors.dart';

const String myUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
    profile_image_url
  }
}
''';

const String myCommentsDescendingQuery = '''
  query MyQuery(\$user_id: String!) {
    comments(order_by: {created_at: desc}, where: {user_id: {_eq: \$user_id}}) {
      id
      created_at
      text
      user {
        id
        name
        profile_image_url
      }
    }
  }
''';

const String myCommentsAscendingQuery = '''
  query MyQuery(\$user_id: String!) {
    comments(order_by: {created_at: asc}, where: {user_id: {_eq: \$user_id}}) {
      id
      created_at
      text
      user_id
      article_id
    }
  }
''';

class MyPageLoggedIn extends StatefulWidget {
  const MyPageLoggedIn({Key? key}) : super(key: key);

  @override
  _MyPageLoggedInState createState() => _MyPageLoggedInState();
}

class _MyPageLoggedInState extends State<MyPageLoggedIn>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'コメント（新しい順）'),
    Tab(text: 'コメント（古い順）'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: _buildSliverAppBar(context),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContentScrollView(
            const PageStorageKey<String>('0'),
            myCommentsDescendingQuery,
          ),
          _buildContentScrollView(
            const PageStorageKey<String>('1'),
            myCommentsAscendingQuery,
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
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
                      builder: (context) => const SettingPage()));
            },
            icon: const Icon(Icons.settings))
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Container(
          child: _buildBarContent(context),
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: tabs,
      ),
    );
  }

  Widget _buildBarContent(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 192,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMyUserQuery(),
            _buildEditProfileButton(context),
          ],
        )));
  }

  Query _buildMyUserQuery() {
    return Query(
      options: QueryOptions(
        document: gql(myUserQuery),
        variables: <String, dynamic>{
          'id': FirebaseAuth.instance.currentUser?.uid ?? '',
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
          style: TextStyle(color: AppColors().textPrimary),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  SizedBox _buildEditProfileButton(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 160,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const EditProfilePage(),
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
    );
  }

  Builder _buildContentScrollView(Key key, String query) {
    return Builder(
      builder: (BuildContext _context) {
        return CustomScrollView(
          key: key,
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(_context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: _ContentQuery(query: query),
            ),
          ],
        );
      },
    );
  }
}

class _ContentQuery extends StatelessWidget {
  const _ContentQuery({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(query),
        variables: <String, dynamic>{
          'user_id': FirebaseAuth.instance.currentUser?.uid ?? '',
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
        return CommentListItem(
          comment: comment,
        );
      }, childCount: comments.length),
    );
  }
}
