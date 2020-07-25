import 'package:fish_redux/fish_redux.dart';
import 'package:sample/exception_component/state.dart';
import 'package:sample/home_page/fence_list/todo_component/state.dart';
import 'package:sample/loading_component/state.dart';

class FenceListState extends MutableSource
    implements Cloneable<FenceListState> {
  List<ToDoState> toDos;
  bool loading;
  bool empty;
  String msg;


  @override
  FenceListState clone() {
    return FenceListState()
      ..toDos = toDos;
  }

  @override
  Object getItemData(int index) => toDos[index];

  @override
  String getItemType(int index) => 'toDo';

  @override
  int get itemCount => toDos?.length ?? 0;

  @override
  void setItemData(int index, Object data) => toDos[index] = data;
}

FenceListState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return FenceListState();
}

/* class ReportConnector extends ConnOp<FenceListState, ReportState>
    with ReselectMixin<FenceListState, ReportState> {
  @override
  ReportState computed(FenceListState state) {
    return ReportState()
      ..done = state.toDos.where((ToDoState tds) => tds.fence_status == 1).length
      ..total = state.toDos.length;
  }

  @override
  List<dynamic> factors(FenceListState state) {
    return <int>[
      state.toDos.where((ToDoState tds) => tds.fence_status == 1).length,
      state.toDos.length
    ];
  }

  @override
  void set(FenceListState state, ReportState subState) {
    throw Exception('Unexcepted to set FenceListState from ReportState');
  }
} */

class LoadingConnector extends ConnOp<FenceListState, LoadingState>{
  @override
  LoadingState get(FenceListState state) {
    final LoadingState cub = LoadingState();
    cub.isLoading= state.loading;
    return cub;
  }

  @override
  void set(FenceListState state, LoadingState subState) {
    state.loading = subState.isLoading;
  }
}
class ExceptionConnector extends ConnOp<FenceListState, ExceptionState>{
  @override
  ExceptionState get(FenceListState state) {
    final ExceptionState cub = ExceptionState();
    cub.msg= state.msg;
    return cub;
  }

  @override
  void set(FenceListState state, ExceptionState subState) {
    state.msg = subState.msg;
  }
}
