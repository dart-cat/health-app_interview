import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/hotlines_bloc.dart';
import 'package:vstrecha/presentation/widgets/menu_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';
import 'package:vstrecha/presentation/widgets/search_bar.dart';

class HotlinesPage extends StatefulWidget {
  const HotlinesPage({super.key});

  @override
  State<HotlinesPage> createState() => _HotlinesPageState();
}

class _HotlinesPageState extends State<HotlinesPage> {
  String searchText = '';

  Future<void> _dialogBuilder(
    BuildContext context,
    String title,
    String phones,
  ) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/icons/close.svg'),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 4)),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 24)),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 32,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/phone.svg'),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Text(
                        phones,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(title: 'hotlines'.i18n()),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: MainSearchBar(
            onChange: (value) {
              setState(() {
                searchText = value;
                BlocProvider.of<HotlinesBloc>(context).add(
                  SearchHotlinesEvent(query: value),
                );
              });
            },
            text: searchText,
            hint: 'enter-query'.i18n(),
            // trailing: SvgPicture.asset('assets/icons/filters.svg'),
          ),
        ),
        BlocBuilder<HotlinesBloc, HotlinesState>(
          builder: (context, state) {
            if (state is HotlinesSearch) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: MenuItem(
                        onTap: () {
                          return _dialogBuilder(
                            context,
                            state.results[index].name,
                            state.results[index].phone ?? '',
                          );
                        },
                        trailing: SvgPicture.asset('assets/icons/dots.svg'),
                        label: state.results[index].type_help_id.name,
                      ),
                    );
                  },
                ),
              );
            }
            if (state is HotlinesLoaded) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.hotlines.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: MenuItem(
                        onTap: () {
                          return _dialogBuilder(
                            context,
                            state.hotlines[index].name,
                            state.hotlines[index].phone ?? '',
                          );
                        },
                        trailing: SvgPicture.asset('assets/icons/dots.svg'),
                        label: state.hotlines[index].type_help_id.name,
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
