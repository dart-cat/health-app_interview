import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/content_bloc.dart';
import 'package:vstrecha/bloc/hotlines_bloc.dart';
import 'package:vstrecha/bloc/institutions_bloc.dart';

import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/repositories/quiz_repository.dart';
import 'package:vstrecha/presentation/widgets/menu_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: MediaQuery.of(context).size.width * 0.32,
      ),
      children: [
        MenuItem(
          onTap: () {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            var institutions = BlocProvider.of<InstitutionsBloc>(context);
            institutions.add(LoadInstitutionsEvent());
            bloc.add(const PushPageEvent(path: '/institutions'));
          },
          leading: SvgPicture.asset(
            'assets/icons/institution_base.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'institution-base'.i18n(),
        ),
        MenuItem(
          onTap: () {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            var hotlines = BlocProvider.of<HotlinesBloc>(context);
            hotlines.add(LoadHotlinesEvent());
            bloc.add(const PushPageEvent(path: '/hotlines'));
          },
          leading: SvgPicture.asset(
            'assets/icons/quick_help.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'quick-help'.i18n(),
        ),
        MenuItem(
          onTap: () {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            bloc.add(const PushPageEvent(
              path: '/personal',
              currentIndex: 3,
            ));
          },
          leading: SvgPicture.asset(
            'assets/icons/personal_area.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'personal-area'.i18n(),
        ),
        MenuItem(
          onTap: () {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            var content = BlocProvider.of<ContentBloc>(context);
            content.add(LoadSectionsEvent());
            bloc.add(const PushPageEvent(path: '/library'));
          },
          leading: SvgPicture.asset(
            'assets/icons/library.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'library'.i18n(),
        ),
        MenuItem(
          onTap: () {
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            var institutions = BlocProvider.of<InstitutionsBloc>(context);
            institutions.add(LoadInstitutionsAbroadEvent());
            bloc.add(const PushPageEvent(path: '/abroad'));
          },
          leading: SvgPicture.asset(
            'assets/icons/help_abroad.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'help-abroad'.i18n(),
        ),
        MenuItem(
          onTap: () {
            QuizRepository.instance.init();
            MainBloc bloc = BlocProvider.of<MainBloc>(context);
            bloc.add(const PushPageEvent(path: '/quiz'));
          },
          leading: SvgPicture.asset(
            'assets/icons/quiz.svg',
            width: 37,
            height: 37,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 23,
            height: 23,
          ),
          label: 'quiz'.i18n(),
        ),
      ],
    );
  }
}
