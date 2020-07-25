import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';
import 'package:sample/device_edit_page/page.dart';
import 'package:sample/device_page/page.dart';
import 'package:sample/fence_edit_page/page.dart';
import 'package:sample/fence_supply_page/page.dart';
import 'package:sample/home_page/page.dart';
import 'package:sample/login_page/page.dart';
import 'package:sample/modify_password_page/page.dart';
import 'package:sample/modify_phone_page/page.dart';
import 'package:sample/network_disconnect/page.dart';
import 'package:sample/pet_edit_page/page.dart';
import 'package:sample/register_page/page.dart';
import 'package:sample/reset_password_page/page.dart';
import 'package:sample/set_page/page.dart';
import 'package:sample/user_agreement_page/page.dart';

import 'global_store/state.dart';
import 'global_store/store.dart';
import 'todo_edit_page/page.dart';
import 'todo_list_page/page.dart';

/// 创建应用的根 Widget
/// 1. 创建一个简单的路由，并注册页面
/// 2. 对所需的页面进行和 AppStore 的连接
/// 3. 对所需的页面进行 AOP 的增强
Widget createApp() {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      ///home
      'home': HomePage(),
      /// 注册TodoList主页面
      'todo_list': ToDoListPage(),

      /// 注册Todo编辑页面
      'todo_edit': TodoEditPage(),
      /// 电子围栏编辑
      'fence_edit': FenceEditPage(),
      /// 登录
      'login': LoginPage(),
      /// 注册
      'register': RegisterPage(),
      /// 修改密码
      'modify_password': ModifyPasswordPage(),
      /// 修改手机号
      'modify_phone': ModifyPhonePage(),
      /// 忘记密码
      'reset_password': ResetPasswordPage(),
      /// 设置页面
      'set': SetPage(),
      /// 设备
      'device': DevicePage(),
      /// 设备编辑
      'device_edit': DeviceEditPage(),
      /// 宠物编辑
      'pet_edit': PetEditPage(),
      /// 围栏补充信息
      'fence_supply': FenceSupplyPage(),
      /// 用户协议
      'user_agreement': UserAgreeMentPage(),
      /// 网络异常
      'network_disconnect': NetWorkDisconnectPage()
    },
    visitor: (String path, Page<Object, dynamic> page) {
      /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
      /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
      if (page.isTypeof<GlobalBaseState>()) {
        /// 建立 AppStore 驱动 PageStore 的单向数据连接
        /// 1. 参数1 AppStore
        /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          final GlobalBaseState p = pagestate;
          if (p.themeColor != appState.themeColor) {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;
              return newState;
            }
          } else {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.flutterMapState = appState.flutterMapState;
              newState.userState = appState.userState;
              newState.currentLocation = appState.currentLocation;
              return newState;
            }
          }
          return pagestate;
        });
      }

      /// AOP
      /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
      /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: <EffectMiddleware<dynamic>>[
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );

  return OKToast(
      dismissOtherOnShow: true,
      child: MaterialApp(
        title: '呵护宝',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue[500], // 主色系
          brightness: Brightness.light, // 亮度主题
          accentColor: Colors.blue[500], // 强调颜色，次级色，决定大多数Widget的颜色，如进度条、开关等。
          cardColor: Colors.white, // 卡片颜色
          dividerColor: Colors.grey[300], // 分割线颜色
          primarySwatch: Colors.blue, 
          cursorColor: Colors.blue[500], // 输入光标颜色
          dialogBackgroundColor: Colors.white, // 对话框背景色
          backgroundColor: Colors.grey,
          // fontFamily: '', // 文字字体
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.red),
            bodyText2: TextStyle(color: Colors.black87),
            button: const TextStyle(color: Colors.white)
          ), // 字体主题，包括标题、body等文字样式
          iconTheme: const IconThemeData(
            // size: 2
          ), // Icon的默认样式
          cardTheme: const CardTheme(elevation: 4, margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
          // 弹出框主题
          dialogTheme: DialogTheme(titleTextStyle: const TextStyle(fontSize: 14, color: Colors.black,), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(size: 2, color: Colors.white),
            actionsIconTheme: IconThemeData(size: 2, color: Colors.white),
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white, letterSpacing: 8, fontSize: 16))
          ), // 顶部栏主题
          buttonTheme: ButtonThemeData( // 按钮主题
            height: 40,
            buttonColor: Colors.blue,
            disabledColor: Colors.grey,
            focusColor: Colors.blue,
            hoverColor: Colors.blue,
            highlightColor: Colors.blue[600],
            splashColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        home: routes.buildPage('home', null),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<Object>(builder: (BuildContext context) {
            return routes.buildPage(settings.name, settings.arguments);
          });
        },
      )
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}