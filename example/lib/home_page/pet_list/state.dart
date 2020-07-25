import 'package:fish_redux/fish_redux.dart';
import 'package:sample/exception_component/state.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart';
import 'package:sample/loading_component/state.dart';


class PetListState extends MutableSource implements Cloneable<PetListState> {
  List<ToDoState> toDos;
  int pageNum;
  int pageLimit;
  bool isLoading;
  bool isEmpty;
  String msg;

  @override
  PetListState clone() {
    return PetListState()
      ..toDos = toDos
      ..pageNum = pageNum
      ..pageLimit = pageLimit
      ..isLoading = isLoading
      ..isEmpty = isEmpty
      ..msg = msg;
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

PetListState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return PetListState();
}

/* class ReportConnector extends ConnOp<PetListState, ReportState>
    with ReselectMixin<PetListState, ReportState> {
  @override
  ReportState computed(PetListState state) {
    return ReportState()
      ..done = state.toDos.where((ToDoState tds) => tds.isDone).length
      ..total = state.toDos.length;
  }

  @override
  List<dynamic> factors(PetListState state) {
    return <int>[
      state.toDos.where((ToDoState tds) => tds.isDone).length,
      state.toDos.length
    ];
  }

  @override
  void set(PetListState state, ReportState subState) {
    throw Exception('Unexcepted to set PetListState from ReportState');
  }
} */

class LoadingConnector extends ConnOp<PetListState, LoadingState>{
  @override
  LoadingState get(PetListState state) {
    final LoadingState cub = LoadingState();
    cub.isLoading= state.isLoading;
    return cub;
  }

  @override
  void set(PetListState state, LoadingState subState) {
    state.isLoading = subState.isLoading;
  }
}
class ExceptionConnector extends ConnOp<PetListState, ExceptionState>{
  @override
  ExceptionState get(PetListState state) {
    final ExceptionState cub = ExceptionState();
    cub.msg= state.msg;
    return cub;
  }

  @override
  void set(PetListState state, ExceptionState subState) {
    state.msg = subState.msg;
  }
}
