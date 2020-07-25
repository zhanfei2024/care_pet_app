import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/home_page/action.dart';

import 'state.dart';

Widget buildView(PetListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  Future<void> _onRefresh() async {
    await Future<dynamic>.delayed(const Duration(seconds: 2)).then((dynamic e){
      dispatch(HomeActionCreator.onRefreshPetAction());
    });
  }
  return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          state.isLoading ? viewService.buildComponent('loading')
          : state.isEmpty ? viewService.buildComponent('exception')
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
}
