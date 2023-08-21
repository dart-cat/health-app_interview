import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/screens/age_check.dart';
import 'package:vstrecha/presentation/widgets/main_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _initialCheck().then((value) {
      if (value) {
        BlocProvider.of<MainBloc>(context).add(LoadMainEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _initialCheck() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('initialCheck') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (prev, current) => prev.runtimeType != current.runtimeType,
      builder: (BuildContext context, MainState currentState) {
        if (currentState is MainInitial) {
          return const AgeCheckScreen();
        }
        if (currentState is MainLoaded) {
          return WillPopScope(
            child: const MainPage(),
            onWillPop: () async {
              if (currentState.history.length == 1) {
                return true;
              } else {
                BlocProvider.of<MainBloc>(context).add(PopPageEvent());
                return false;
              }
            },
          );
        }
        if (currentState is MainError) {
          return Scaffold(
            body: Center(
              child: Text(
                currentState.errorMessage,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
