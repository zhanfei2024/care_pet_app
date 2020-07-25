import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/home_page/action.dart';

import 'state.dart';

Widget buildView(FenceListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  // ignore: unused_element
  Future<void> _onRefresh() async {
    await Future<dynamic>.delayed(const Duration(seconds: 2)).then((dynamic e){
      dispatch(HomeActionCreator.onRefreshFenceAction());
    });
  }
  return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          state.loading ? viewService.buildComponent('loading')
          : state.empty ? viewService.buildComponent('exception')
          :
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                itemBuilder: adapter.itemBuilder,
                itemCount: adapter.itemCount
              ),
              onRefresh: _onRefresh
            )
          )
        ],
      ),
    );
    /* floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(PageActionCreator.onAddAction()),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    ), */
}
