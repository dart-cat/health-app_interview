import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/data/models/institution.dart';

class InstitutionDetailPage extends StatelessWidget {
  
  const InstitutionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionsBloc, InstitutionsState>(
      builder: (context, state) {
        if (state is InstitutionsLoaded) {
          final Institution? institution;
          if (state.searchResults == null) {
            institution = state.institutions[state.currentIndex ?? 0];
          } else {
            institution = state.searchResults?[state.currentIndex ?? 0];
          }


          final cleanedPhoneNumber = institution!.phone!.replaceAll(RegExp(r'[()\s-]'), '');

          String websiteLink = institution.link_website!;
          if (!websiteLink.startsWith('http://') && !websiteLink.startsWith('https://')) {
  websiteLink = 'https://$websiteLink';
}

          return Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                Text(
                  institution.name,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    institution.photo,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/main/placeholder.jpg'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  constraints: const BoxConstraints(minHeight: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/location.svg'),
                      const Padding(padding: EdgeInsets.only(left: 16)),
                      Expanded(
                        child: Text(
                          institution.address,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  constraints: const BoxConstraints(minHeight: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/phone.svg'),
                      const Padding(padding: EdgeInsets.only(left: 16)),
                      Flexible(
                        child: SelectableAutoLinkText(
                          
                          cleanedPhoneNumber,
                          linkStyle: const TextStyle(color: Colors.blueAccent),
                          onTap: (url) => launchUrl(Uri.parse(url)),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  constraints: const BoxConstraints(minHeight: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/envelope.svg'),
                      const Padding(padding: EdgeInsets.only(left: 16)),
                      Flexible(
                        child: SelectableAutoLinkText(
                          '${institution.email}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  constraints: const BoxConstraints(minHeight: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/globe.svg'),
                      const Padding(padding: EdgeInsets.only(left: 16)),
                      Flexible(
                        child: SelectableAutoLinkText(
                          websiteLink,
                          linkStyle: const TextStyle(color: Colors.blueAccent),
                          onTap: (url) => launchUrl(Uri.parse(url)),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  'about-institution'.i18n(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Text(
                  institution.description!,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                institution.add_info != null
                    ? const Padding(padding: EdgeInsets.only(bottom: 8))
                    : Container(),
                institution.add_info != null
                    ? Text(
                        institution.add_info!,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(bottom: 16)),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
