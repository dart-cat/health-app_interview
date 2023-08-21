import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/providers/cached_tile_provider.dart';
import 'package:vstrecha/presentation/widgets/institution_card.dart';

class InstitutionsPage extends StatelessWidget {
  const InstitutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          floating: false,
          expandedHeight: MediaQuery.of(context).size.width * 0.81,
          flexibleSpace: FlexibleSpaceBar(
            background: FlutterMap(
              options: MapOptions(
                center: LatLng(53.9346196, 27.5633294),
                zoom: 5.7,
                maxZoom: 16,
                minZoom: 5,
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'by.HealthNavigator.Plus',
                  tileProvider: CachedTileProvider(),
                ),
                BlocBuilder<InstitutionsBloc, InstitutionsState>(
                  builder: (context, state) {
                    if (state is InstitutionsLoaded) {
                      return MarkerLayer(
                        markers: state.institutions
                            .map((e) {
                              try {
                                final coordinates = e.coordinates ?? '';
                                final coordinatesParts = coordinates.split(',');

                                if (coordinatesParts.length >= 2) {
                                  final latitude =
                                      double.parse(coordinatesParts[0]);
                                  final longitude =
                                      double.parse(coordinatesParts[1]);

                                  return Marker(
                                    point: LatLng(latitude, longitude),
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          final toCard = state
                                              .institutions //suicide
                                              .where((element) =>
                                                  element.coordinates ==
                                                  coordinates);
                                          if (toCard.isNotEmpty) {
                                            final i = state.institutions
                                                .indexOf(toCard.first, 0);
                                            BlocProvider.of<InstitutionsBloc>(
                                                    context)
                                                .add(DetailInstitutionEvent(
                                                    index: i));
                                            BlocProvider.of<MainBloc>(context)
                                                .add(const PushPageEvent(
                                                    path: '/institution'));
                                          } else {
                                            return;
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/location.svg',
                                        ),
                                      );
                                    },
                                  );
                                }
                              } catch (error) {
                                print('Error parsing coordinates: $error');
                              }

                              return null;
                            })
                            .where((marker) => marker != null)
                            .toList()
                            .cast<Marker>(),
                      );
                    }
                    return const MarkerLayer();
                  },
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 16,
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
                        title:
                            '${institutions[index].name}, ${institutions[index].city_id?.name}',
                        onTap: () {
                          BlocProvider.of<InstitutionsBloc>(context)
                              .add(DetailInstitutionEvent(index: index));
                          BlocProvider.of<MainBloc>(context)
                              .add(const PushPageEvent(path: '/institution'));
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
