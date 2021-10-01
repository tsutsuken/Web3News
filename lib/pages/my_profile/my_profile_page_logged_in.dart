import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/comment_bottom_sheet.dart';
import 'package:labo_flutter/components/comment_list_item.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/pages/edit_profile_page.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_notifier.dart';
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

class MyProfilePageLoggedIn extends ConsumerStatefulWidget {
  const MyProfilePageLoggedIn({Key? key}) : super(key: key);

  @override
  _MyProfilePageLoggedInState createState() => _MyProfilePageLoggedInState();
}

class _MyProfilePageLoggedInState extends ConsumerState<MyProfilePageLoggedIn>
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
        children: const [
          _ContentScrollView(
            key: PageStorageKey<String>('0'),
            contentType: MyProfilePageContentType.descendingMyComments,
          ),
          _ContentScrollView(
            key: PageStorageKey<String>('1'),
            contentType: MyProfilePageContentType.ascendingMyComments,
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
}

class _ContentScrollView extends ConsumerStatefulWidget {
  const _ContentScrollView({Key? key, required this.contentType})
      : super(key: key);

  final MyProfilePageContentType contentType;

  @override
  _ContentScrollViewState createState() => _ContentScrollViewState();
}

class _ContentScrollViewState extends ConsumerState<_ContentScrollView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pageNotifier =
        ref.watch(myProfilePageNotifierProvider(widget.contentType));
    return Builder(
      builder: (BuildContext _context) {
        return GraphQLConsumer(builder: (GraphQLClient client) {
          return CustomScrollView(
            key: widget.key,
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(_context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: _ContentQuery(
                  pageNotifier: pageNotifier,
                  client: client,
                ),
              ),
            ],
          );
        });
      },
    );
  }
}

class _ContentQuery extends StatelessWidget {
  const _ContentQuery(
      {Key? key, required this.pageNotifier, required this.client})
      : super(key: key);

  final MyProfilePageNotifier pageNotifier;
  final GraphQLClient client;

  Future<void> _onTapMenuButton(BuildContext context,
      MyProfilePageNotifier pageNotifier, Comment comment) async {
    await showCommentBottomSheet(
      context,
      comment: comment,
      onTapDeleteContent: () async {
        final didSuccess = await pageNotifier.deleteComment(comment.id);

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = '削除しました';
        } else {
          message = 'エラーが発信しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

        // TODO: リストを更新
      },
      onTapReportContent: () {
        debugPrint('onTapReportContent');
      },
      onTapBlockUser: () {
        debugPrint('onTapBlockUser');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageNotifier.commentsValue.when(
      data: (comments) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final comment = comments[index];
            return CommentListItem(
              comment: comment,
              onTapMenuButton: () async {
                await _onTapMenuButton(context, pageNotifier, comment);
              },
            );
          }, childCount: comments.length),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(child: Text('ローディング中...'));
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(child: Text('エラーが発生しました: $error'));
      },
    );
  }
}
