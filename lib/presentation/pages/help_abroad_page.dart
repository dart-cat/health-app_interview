import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/widgets/institution_card.dart';

class HelpAbroadPage extends StatelessWidget {
  const HelpAbroadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: MediaQuery.of(context).size.width * 0.32,
              bottom: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'institutions'.i18n(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    MainBloc bloc = BlocProvider.of<MainBloc>(context);
                    bloc.add(const PushPageEvent(
                      path: '/search',
                      enableBackground: false,
                      enableHeader: false,
                      enableNavbar: false,
                    ));
                  },
                  child: SvgPicture.asset('assets/icons/search.svg'),
                ),
                const Padding(padding: EdgeInsets.only(left: 24)),
                GestureDetector(
                  onTap: () {
                    MainBloc bloc = BlocProvider.of<MainBloc>(context);
                    bloc.add(const PushPageEvent(
                      path: '/filters',
                      enableBackground: false,
                      enableHeader: false,
                      enableNavbar: false,
                    ));
                  },
                  child: SvgPicture.asset('assets/icons/filters.svg'),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<InstitutionsBloc, InstitutionsState>(
          builder: (context, state) {
            if (state is InstitutionsLoaded) {
              final institutions = state.institutions;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      child: InstitutionCard(
                        imageUrl: institutions[index].photo,
                        title: institutions[index].name,
                        location:
                            '${institutions[index].city_id?.name}, ${institutions[index].country_id?.name}',
                        onTap: () {
                          BlocProvider.of<InstitutionsBloc>(context)
                              .add(DetailInstitutionEvent(index: index));
                          BlocProvider.of<MainBloc>(context).add(const PushPageEvent(path: '/institution'));
                        },
                      ),
                    );
                  },
                  childCount: institutions.length,
                ),
              );
            }
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
