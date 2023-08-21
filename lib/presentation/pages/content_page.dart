import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vstrecha/bloc/content_bloc.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoaded) {
          return Column(
            children: [
              PageHeader(title: state.title),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      SelectionArea(
                        child: Html(
                          data: state.text,
                          
                          onLinkTap: (link, _, __, ___) async {
                            if (link == null) return;
                            final uri = Uri.parse(link);
                            final canLaunch = await canLaunchUrl(uri);
                            if (!canLaunch) return;
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ContentLoading) {
          return Column(
            children: [
              PageHeader(title: state.title),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
