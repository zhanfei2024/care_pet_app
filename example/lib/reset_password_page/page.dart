import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ResetPasswordPage extends Page<ResetPasswordState, Map<String, dynamic>> {
  ResetPasswordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /* dependencies: Dependencies<ResetPasswordState>(
              slots: <String, Dependent<ResetPasswordState>>{
                'home': HomeConnector() + HomeComponent(),
                'category': CategoryConnector() + CategoryComponent(),
                'subject': SubjectConnector() + SubjectComponent(),
                'member': MemberConnector() + MemberComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<ResetPasswordState>>[
          //   logMiddleware(tag: 'ResetPasswordPage'),
          // ],
        );
}
