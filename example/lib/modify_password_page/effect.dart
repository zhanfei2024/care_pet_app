import 'package:fish_redux/fish_redux.dart';
import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<ModifyPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ModifyPasswordState>>{
    ModifyPasswordAction.onTab: _onTab,
    ModifyPasswordAction.onDone: _onDone,
    ModifyPasswordAction.onChangeTheme: _onChangeTheme,
  });
}

void _onTab(Action action, Context<ModifyPasswordState> ctx) {
  final ModifyPasswordState state = ctx.state.clone();
  state.currentIndex = action.payload;
  ctx.dispatch(ModifyPasswordActionCreator.updateStateAction(state));
}
void _onDone(Action action, Context<ModifyPasswordState> ctx) {
 /*  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  ); */
}

void _onChangeTheme(Action action, Context<ModifyPasswordState> ctx) {
 /*  */ GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
