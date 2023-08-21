import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/widgets/main_background.dart';
import 'package:vstrecha/presentation/widgets/main_header.dart';
import 'package:vstrecha/presentation/widgets/main_navbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, currentState) {
        if (currentState is MainLoaded) {
          return Scaffold(
            body: Stack(
              children: [
                currentState.enableBackground
                    ? const MainBackground()
                    : Container(),
                currentState.page,
                currentState.enableHeader ? const MainHeader() : Container(),
              ],
            ),
            bottomNavigationBar:
                currentState.enableNavbar ? const MainNavigationBar() : null,
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
