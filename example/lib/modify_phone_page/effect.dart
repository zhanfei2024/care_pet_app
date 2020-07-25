import 'package:fish_redux/fish_redux.dart';
import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<ModifyPhoneState> buildEffect() {
  return combineEffects(<Object, Effect<ModifyPhoneState>>{
    ModifyPhoneAction.onTab: _onTab,
    ModifyPhoneAction.onDone: _onDone,
    ModifyPhoneAction.onChangeTheme: _onChangeTheme,
  });
}

void _onTab(Action action, Context<ModifyPhoneState> ctx) {
  final ModifyPhoneState state = ctx.state.clone();
  state.currentIndex = action.payload;
  ctx.dispatch(ModifyPhoneActionCreator.updateStateAction(state));
}
void _onDone(Action action, Context<ModifyPhoneState> ctx) {
 /*  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  ); */
}

void _onChangeTheme(Action action, Context<ModifyPhoneState> ctx) {
 /*  */ GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
