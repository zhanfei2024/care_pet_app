import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LoginPage extends Page<LoginState, Map<String, dynamic>> {
  LoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /* dependencies: Dependencies<LoginState>(
              slots: <String, Dependent<LoginState>>{
                'home': HomeConnector() + HomeComponent(),
                'category': CategoryConnector() + CategoryComponent(),
                'subject': SubjectConnector() + SubjectComponent(),
                'member': MemberConnector() + MemberComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<LoginState>>[
          //   logMiddleware(tag: 'LoginPage'),
          // ],
        );
}
