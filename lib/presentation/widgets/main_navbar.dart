import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/calendar_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (index) {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            CalendarBloc calendar = BlocProvider.of<CalendarBloc>(context);
            switch (index) {
              case 0:
                bloc.add(const ReplacePageEvent(
                  path: '/',
                  currentIndex: 0,
                ));
                break;
              case 1:
                bloc.add(const ReplacePageEvent(
                  path: '/chat',
                  currentIndex: 1,
                  enableHeader: false,
                  enableBackground: false,
                ));
                break;
              case 2:
                calendar.add(const LoadCalendarEvents());
                bloc.add(const ReplacePageEvent(
                  path: '/calendar',
                  currentIndex: 2,
                ));
                break;
              case 3:
                bloc.add(const ReplacePageEvent(
                  path: '/personal',
                  currentIndex: 3,
                ));
                break;
              default:
                break;
            }
          },
          currentIndex: (state as MainLoaded).currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 20,
          elevation: 16,
          selectedItemColor: const Color(0xff254cb1),
          unselectedItemColor: const Color(0xff979797),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home_unselected.svg'),
              activeIcon: SvgPicture.asset('assets/icons/home_selected.svg'),
              label: 'main-page'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/chat_unselected.svg'),
              activeIcon: SvgPicture.asset('assets/icons/chat_selected.svg'),
              label: 'chat-page'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/schedule_unselected.svg'),
              activeIcon:
                  SvgPicture.asset('assets/icons/schedule_selected.svg'),
              label: 'schedule-page'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/man_unselected.svg'),
              activeIcon: SvgPicture.asset('assets/icons/man_selected.svg'),
              label: 'personal-page'.i18n(),
            ),
          ],
        );
      },
    );
  }
}
