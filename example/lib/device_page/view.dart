import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DeviceState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  Future<void> _onRefresh() async {
    await Future<dynamic>.delayed(const Duration(seconds: 2)).then((dynamic e){
      dispatch(PageActionCreator.onRefreshDeviceAction());
    });
  }
  final ScrollController _scrollController = ScrollController(initialScrollOffset: state.maxScrollExtent);
    _scrollController.addListener((){
    //判断是否滑动到了页面的最底部
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      //如果不是最后一页数据，则生成新的数据添加到list里面
      if(state.isLastPageNum == false) {
        dispatch(PageActionCreator.onLoadMoreAction(_scrollController.position.maxScrollExtent));
      } else {
        dispatch(PageActionCreator.onShowLastEndAction());
      }
    }
  });
  return Scaffold(
    appBar: AppBar(
      title: const Text('我的设备'), 
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            dispatch(PageActionCreator.onAddAction());
        })
      ],
      bottom: Style.preferredSize),
    body: Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          state.isDevicesLoading ? viewService.buildComponent('loading')
          : state.isDevicesEmpty ? viewService.buildComponent('exception')
          :
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                itemBuilder: adapter.itemBuilder,
                itemCount: adapter.itemCount,
                controller: _scrollController,
              ),
              onRefresh: _onRefresh
            )
          ),
          state.showLastEnd == true ? const Text('已经到底了...') : const SizedBox(height: 0),
          state.showMoreLoading == true ? const Text('努力加载中...') : const SizedBox(height: 0)
        ],
      ),
    ),
  );
}
