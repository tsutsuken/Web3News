import 'package:flutter/material.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefresherHeader extends StatelessWidget {
  const RefresherHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? status) {
        return const LoadingIndicator();
      },
      height: 96,
    );
  }
}
