part of 'home_cubit.dart';

enum HomeTab { collection, main, profile }

class HomeState extends Equatable {
  const HomeState({this.currentTab = HomeTab.main}); // Important : by default main is selected !
  final HomeTab currentTab;

  @override
  List<Object> get props => [currentTab];
}
