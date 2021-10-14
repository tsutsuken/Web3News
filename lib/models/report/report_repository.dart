import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';

const String insertReportMutation = '''
  mutation MyMutation(\$comment_id: uuid!) {
    insert_reports_one(object: {comment_id: \$comment_id}) {
      id
    }
  }
''';

final reportRepositoryProvider = Provider.autoDispose<ReportRepositoryImpl>(
  (ref) {
    final graphQLClientNotifier = ref.read(graphQLClientProvider);
    return ReportRepositoryImpl(graphQLClientNotifier.value);
  },
);

abstract class ReportRepository {
  Future<bool> addReport(String commentId);
}

class ReportRepositoryImpl implements ReportRepository {
  ReportRepositoryImpl(this._client);
  final GraphQLClient _client;

  @override
  Future<bool> addReport(String commentId) async {
    debugPrint('addReport commentId: $commentId');
    var didSuccess = false;

    final result = await _client.mutate(
      MutationOptions(
        document: gql(insertReportMutation),
        variables: <String, dynamic>{
          'comment_id': commentId,
        },
      ),
    );
    if (result.hasException) {
      debugPrint('addReport exception: ${result.exception.toString()}');
    } else {
      didSuccess = true;
    }

    return didSuccess;
  }
}
