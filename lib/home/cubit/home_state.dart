part of 'home_cubit.dart';

enum HomeTab { collection, main, profile }

class HomeState extends Equatable {
  const HomeState({this.tab = HomeTab.main}); // Important : by default main is selected !
  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
