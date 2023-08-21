import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/institution.dart';
import 'package:vstrecha/presentation/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 8,
            right: 8,
          ),
          child: MainSearchBar(
            onChange: (text) {
              setState(() {
                searchText = text;
              });
              var bloc = BlocProvider.of<InstitutionsBloc>(context);
              bloc.add(SearchInstitutionsEvent(query: text));
            },
            text: searchText,
            hint: 'enter-institution'.i18n(),
            trailing: TextButton(
              onPressed: () {
                MainBloc bloc = BlocProvider.of<MainBloc>(context);
                bloc.add(PopPageEvent());
              },
              child: Text(
                'cancel'.i18n(),
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Expanded(
          child: BlocBuilder<InstitutionsBloc, InstitutionsState>(
            builder: (context, state) {
              if (state is InstitutionsLoaded) {
                List<Institution> results = state.searchResults ?? [];
                if (results.isNotEmpty) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<InstitutionsBloc>(context)
                                .add(DetailInstitutionEvent(index: index));
                            BlocProvider.of<MainBloc>(context)
                                .add(const ReplacePageEvent(path: '/'));
                            BlocProvider.of<MainBloc>(context).add(
                            const PushPageEvent(path: '/institutions'));
                            BlocProvider.of<MainBloc>(context)
                                .add(const PushPageEvent(path: '/institution'));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 16,
                              right: 16,
                              bottom: 8,
                            ),
                            child: Text(
                              results[index].name,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
