import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudFunctionsRepositoryProvider =
    Provider.autoDispose<CloudFunctionsRepositoryImpl>(
  (ref) {
    return CloudFunctionsRepositoryImpl();
  },
);

abstract class CloudFunctionsRepository {
  Future<String?> addArticleByUrl(String url);
}

class CloudFunctionsRepositoryImpl implements CloudFunctionsRepository {
  CloudFunctionsRepositoryImpl();

  @override
  Future<String?> addArticleByUrl(String url) async {
    debugPrint('addArticleByUrl url: $url');
    final callable =
        FirebaseFunctions.instance.httpsCallable('addArticleByUrl');
    final result = await callable.call<dynamic>(<String, String>{'url': url});
    final dynamic resultData = result.data;
    String? addedArticleId;
    if (resultData != null) {
      addedArticleId = resultData['id'] as String?;
    }
    debugPrint('addArticleByUrl addedArticleId: $addedArticleId');
    return addedArticleId;
  }
}
