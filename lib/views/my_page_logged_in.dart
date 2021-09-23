import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:labo_flutter/views/edit_profile_view.dart';
import 'package:labo_flutter/views/setting_view.dart';

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

class MyPageLoggedIn extends StatefulWidget {
  const MyPageLoggedIn({Key? key}) : super(key: key);

  @override
  _MyPageLoggedInState createState() => _MyPageLoggedInState();
}

class _MyPageLoggedInState extends State<MyPageLoggedIn>
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
    // return Placeholder();
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        _buildMyCommentsQuery(),
      ],
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
                      builder: (context) => const SettingView()));
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
    );
  }

  Query _buildMyCommentsQuery() {
    return Query(
      options: QueryOptions(
        document: gql(myCommentsQuery),
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
}
