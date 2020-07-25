import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ModifyPhonePage extends Page<ModifyPhoneState, Map<String, dynamic>> {
  ModifyPhonePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /* dependencies: Dependencies<ModifyPhoneState>(
              slots: <String, Dependent<ModifyPhoneState>>{
                'home': HomeConnector() + HomeComponent(),
                'category': CategoryConnector() + CategoryComponent(),
                'subject': SubjectConnector() + SubjectComponent(),
                'member': MemberConnector() + MemberComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<ModifyPhoneState>>[
          //   logMiddleware(tag: 'ModifyPhonePage'),
          // ],
        );
}
