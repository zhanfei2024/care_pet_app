import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Format.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
  ToDoState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  Widget item(String title, dynamic value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setWidth(10)),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(160),
            child: Text(
              '$title：',
              style: TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26)),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black87, fontSize: ScreenUtil().setSp(28)),)
          )
        ],
      ),
    );
  }
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(90),
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: const Icon(Icons.router, textDirection: TextDirection.ltr, color: Colors.white,),
                    margin: const EdgeInsets.all(8.0),
                  ),
                  Expanded(
                    child: Text(
                    '',
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  )),
                  Row(
                    children: <Widget>[
                      Text('已${Format.fenceStatus(state.fence_status)}', style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),),
                      Container(
                        child: Switch(
                          activeColor: Colors.white,
                          value: state.fence_status == 1,//当前状态
                          onChanged:(bool value){
                            dispatch(ToDoActionCreator.onChangeFenceStatusAction());
                          },
                        )
                      ),
                    ]
                  ),
                ],
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        item('围栏名称', state.fence_name),
                        item('围栏描述', state.fence_desc),
                        item('围栏状态', '已${Format.fenceStatus(state.fence_status)}'),
                      ]
                    )
                  ),
                  Container(
                    width: ScreenUtil().setWidth(100),
                    child: IconButton(icon: Icon(Icons.edit, color: Colors.grey,), onPressed: () {
                      dispatch(ToDoActionCreator.onEditAction(state.id));
                    }),
                  )
                ]
              )
            )
          ],
        ),
        onLongPress: () {
          dispatch(ToDoActionCreator.onRemoveAction(state.id));
        },
      ),
    )
  ); 
}
