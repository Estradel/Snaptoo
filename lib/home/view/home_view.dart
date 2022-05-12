import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/Utilities.dart';
import '../cubit/home_cubit.dart';
import '../pages/collection/view/collection_view.dart';
import '../pages/main/view/main_view.dart';
import '../pages/profile/view/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String route = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if selectedTab changes this whole widget will be rebuilt !
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.currentTab);
    return Scaffold(
      body: Utilities.customCase(selectedTab, {
        HomeTab.collection: CollectionView(),
        HomeTab.main: const MainView(),
        HomeTab.profile: const ProfileView(),
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: HomeTab.values.indexOf(selectedTab),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: "Collection"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        onTap: (index) {
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
      ),
    );
  }
}
