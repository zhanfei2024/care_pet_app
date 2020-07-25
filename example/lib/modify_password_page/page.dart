import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ModifyPasswordPage extends Page<ModifyPasswordState, Map<String, dynamic>> {
  ModifyPasswordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /* dependencies: Dependencies<ModifyPasswordState>(
              slots: <String, Dependent<ModifyPasswordState>>{
                'home': HomeConnector() + HomeComponent(),
                'category': CategoryConnector() + CategoryComponent(),
                'subject': SubjectConnector() + SubjectComponent(),
                'member': MemberConnector() + MemberComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<ModifyPasswordState>>[
          //   logMiddleware(tag: 'ModifyPasswordPage'),
          // ],
        );
}
