import 'package:flutter/material.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefresherFooter extends StatelessWidget {
  const RefresherFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? status) {
        return const LoadingIndicator();
      },
      loadStyle: LoadStyle.ShowWhenLoading,
      height: 96,
    );
  }
}
