import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/content_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';

import 'package:vstrecha/presentation/widgets/menu_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is SectionsLoaded) {
          return Column(
            children: [
              PageHeader(title: 'library'.i18n()),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    itemCount: state.children.length,
                    itemBuilder: (context, index) {
                      return MenuItem(
                        onTap: () {
                          //MainBloc main = BlocProvider.of<MainBloc>(context);
                          var content = BlocProvider.of<ContentBloc>(context);
                          content.add(LoadArticlesEvent(
                            id: state.children[index].id,
                          ));
                          //main.add(const PushPageEvent(path: '/content'));
                        },
                        trailing: SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          width: 23,
                          height: 23,
                        ),
                        label: state.children[index].name,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ArticlesLoaded) {
          return Column(
            children: [
              PageHeader(
                onBackAction: () {
                  MainBloc bloc = BlocProvider.of<MainBloc>(context);
                  var content = BlocProvider.of<ContentBloc>(context);
                  content.add(LoadSectionsEvent());
                  bloc.add(const ReplacePageEvent(path: '/'));
                  bloc.add(const PushPageEvent(path: '/library'));
                },
                title: state.name,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return MenuItem(
                      onTap: () {
                        MainBloc main = BlocProvider.of<MainBloc>(context);
                        var content = BlocProvider.of<ContentBloc>(context);
                        content.add(LoadContentEvent(id: index));
                        main.add(const PushPageEvent(path: '/content'));
                      },
                      trailing: SvgPicture.asset(
                        'assets/icons/arrow.svg',
                        width: 23,
                        height: 23,
                      ),
                      label: state.articles[index].title,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
