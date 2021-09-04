import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/views/edit_profile_view.dart';
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
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        _header(context, _userChangeNotifier.currentUser),
        Query(
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
                child: ListView.builder(
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
                    }));
          },
        ),
      ]),
    );
  }

  Widget _header(BuildContext context, User? currentUser) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.redAccent, Colors.pinkAccent])),
        child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Query(
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

                    final resultData =
                        result.data?['users_by_pk'] as Map<String, dynamic>?;
                    if (resultData == null) {
                      return const Text('No User');
                    }

                    final appUser = AppUser.fromJson(resultData);
                    return Text('name: ${appUser.name}, id: ${appUser.id}');
                  },
                ),
                Text('uid: ${currentUser?.uid}'),
                Text('email: ${currentUser?.email}'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const EditProfileView(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text('プロフィール編集')),
                if (currentUser == null) ...[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => const SignInView()),
                        );
                      },
                      child: const Text('サインイン')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => const SignUpView()),
                        );
                      },
                      child: const Text('新規登録')),
                ] else
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('サインアウト'),
                  ),
                Mutation(
                  options: MutationOptions(
                    document: gql(insertCommentMutation),
                    onCompleted: (dynamic resultData) {
                      print('resultData: $resultData');
                    },
                    onError: (e) {
                      print('error: $e');
                    },
                  ),
                  builder: (
                    RunMutation runMutation,
                    QueryResult? result,
                  ) {
                    return ElevatedButton(
                      onPressed: () => runMutation(<String, dynamic>{
                        'text': '本文',
                      }),
                      child: const Text('Commentを追加'),
                    );
                  },
                ),
              ],
            ))),
      ),
    );
  }
}
