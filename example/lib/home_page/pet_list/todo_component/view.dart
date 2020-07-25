import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/home_page/pet_list/todo_component/action.dart';

import 'state.dart';

Widget buildView(
  ToDoState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  String formatStatus(int v) {
    switch (v) {
      case 1:
        return '围栏内';
        break;
      case 2:
        return '围栏外';
        break;
      default:
        return '未知';
    }
  }
  final TextStyle labelStyle = TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.black54,);
  final TextStyle contentStyle = TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.black87);
  return Card(
    borderOnForeground: true,
    clipBehavior: Clip.hardEdge,
    child: Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding:EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(32)),
                    child: state.pet_avatar != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                        child: CachedNetworkImage(
                          imageUrl: state.pet_avatar,
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setWidth(100),
                          fit: BoxFit.cover,
                          placeholder: (BuildContext context, String url) => Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(100),
                            child: SizedBox(
                              height: ScreenUtil().setWidth(100),
                              child: const Text('loading')
                            ),
                          ),
                          errorWidget: (BuildContext context, String url, Object error) => Image.asset(
                            'assets/icon/dz.png',
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(100),
                            fit: BoxFit.cover,
                          ),
                        )
                      )
                      
                      : Image.asset('assets/icon/icon_head_grey@2x.png')
                  ),
                  Expanded(
                    child: Container(
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: ScreenUtil().setWidth(12),
                        children: <Widget>[
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: '设备电量：', style: labelStyle),
                              TextSpan(text: '20%', style: contentStyle),
                            ])
                          ),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: '设备状态：', style: labelStyle),
                              TextSpan(text: '工作中', style: contentStyle),
                            ])
                          ),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: '当前位置：', style: labelStyle),
                              TextSpan(text: '中骏四季阳光东骏路', style: contentStyle),
                            ])
                          ),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: '宠物状态：', style: labelStyle),
                              TextSpan(text: formatStatus(state.pet_status), style: contentStyle),
                            ])
                          ),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: '运动记步：', style: labelStyle),
                              TextSpan(text: '${state.pet_step}步', style: contentStyle),
                            ])
                          ),
                        ],
                      ),
                  )),
                  GestureDetector(
                    child: Container(
                      child: Icon(Icons.edit, color: Colors.grey[500],),
                    ),
                    onTap: () {
                      dispatch(ToDoActionCreator.onEditAction(state.id));
                    },
                  )
                ],
              ),
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
