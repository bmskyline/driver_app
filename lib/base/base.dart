

import 'dart:async';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

abstract class Presenter {

  void onClick(String action);
}

abstract class ItemPresenter<T> {

  void onItemClick(String action, T item);
}

class BaseProvider with ChangeNotifier {

  CompositeSubscription compositeSubscription = CompositeSubscription();


  addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    if (!compositeSubscription.isDisposed) {
      compositeSubscription.dispose();
    }
    super.dispose();
  }
}

abstract class PageProvideNode<T extends ChangeNotifier> extends StatelessWidget implements Presenter {
  final T mProvider;

  PageProvideNode({List<dynamic> params}) : mProvider = inject<T>(params: params);

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: mProvider,
      child: buildContent(context),
    );
  }

  @override
  void onClick(String action) {}
}