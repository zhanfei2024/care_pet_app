import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RegisterPage extends Page<RegisterState, Map<String, dynamic>> {
  RegisterPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /* dependencies: Dependencies<RegisterState>(
              slots: <String, Dependent<RegisterState>>{
                'home': HomeConnector() + HomeComponent(),
                'category': CategoryConnector() + CategoryComponent(),
                'subject': SubjectConnector() + SubjectComponent(),
                'member': MemberConnector() + MemberComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<RegisterState>>[
          //   logMiddleware(tag: 'RegisterPage'),
          // ],
        );
}
