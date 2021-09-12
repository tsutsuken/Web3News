import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/views/edit_profile_view.dart';
import 'package:labo_flutter/views/setting_view.dart';
import 'package:labo_flutter/views/sign_in_view.dart';
import 'package:labo_flutter/views/sign_up_view.dart';

const String myUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
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

const String insertCommentMutation = '''
  mutation MyMutation(\$text: String!) {
    insert_comments_one(object: {text: \$text}) {
      id
    }
  }
''';

class MyPageView extends HookWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userChangeNotifier = useProvider(userChangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LaboFlutter'),
        backgroundColor: Colors.blue,
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
      ),
      body: _userChangeNotifier.currentUser == null
          ? buildNotLoggedInWidget(context)
          : buildLoggedInWidget(context, _userChangeNotifier),
    );
  }

  Widget buildNotLoggedInWidget(
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
          const Text(
            '保存した記事を閲覧',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget buildLoggedInWidget(
      BuildContext context, UserChangeNotifier _userChangeNotifier) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _header(context, _userChangeNotifier.currentUser),
          buildMyCommentsQuery(_userChangeNotifier),
        ]);
  }

  Query buildMyCommentsQuery(UserChangeNotifier _userChangeNotifier) {
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
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Text('Loading');
        }

        var comments = <Comment>[];
        final resultData = result.data;
        if (resultData != null) {
          comments = CommentListResponse.fromJson(resultData).comments;
        }

        return Expanded(
            // The ListView
            child: buildListView(comments));
      },
    );
  }

  ListView buildListView(List<Comment> comments) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = comments[index];
          return ListTile(
            title: Text(comment.text),
            trailing: const Icon(Icons.more_vert),
            subtitle: Text(comment.articleId),
            onTap: () {},
          );
        });
  }

  Widget _header(BuildContext context, User? currentUser) {
    return Container(
      child: Container(
        color: Colors.white,
        child: SizedBox(
            width: double.infinity,
            height: 192,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildMyUserQuery(currentUser),
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
            ))),
      ),
    );
  }

  Query buildMyUserQuery(User? currentUser) {
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
        // return Text(appUser.name);
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
        Text(appUser.name),
        const SizedBox(height: 12),
      ],
    );
  }
}
