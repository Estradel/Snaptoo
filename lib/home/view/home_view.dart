import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:snaptoo/home/cubit/home_cubit.dart';
import 'package:snaptoo/views/collection_view.dart';
import 'package:snaptoo/views/main_view.dart';

import '../../helper/Utilities.dart';
import '../../views/profile_view.dart';

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
    // if currentTab changes this whole widget will be rebuilt !
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.currentTab);
    return Scaffold(
      body: Utilities.customCase(selectedTab, {
        HomeTab.collection: const CollectionView(),
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
