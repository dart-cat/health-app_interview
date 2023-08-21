import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/city.dart';
import 'package:vstrecha/data/models/filter.dart';
import 'package:vstrecha/data/models/type_institution.dart';
import 'package:vstrecha/data/repositories/institutions_repository.dart';
import 'package:vstrecha/presentation/widgets/filter_entry.dart';
import 'package:vstrecha/presentation/widgets/filter_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';
import 'package:vstrecha/presentation/widgets/search_bar.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _loading = true;
  List<City> _cities = [];
  List<TypeInstitution> _types = [];
  City? _selectedCity;
  TypeInstitution? _selectedType;
  Page? _page;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<InstitutionsBloc>(context);
    if (bloc.state is InstitutionsLoaded) {
      _selectedCity = (bloc.state as InstitutionsLoaded).filter.city;
      _selectedType = (bloc.state as InstitutionsLoaded).filter.type;
    }
    _fetchTypesCities(bloc);
  }

  bool _interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_page != null) {
      setState(() {
        _page = null;
        _searchText = '';
      });
      BackButtonInterceptor.remove(_interceptor);
    }
    return true;
  }

  Future<void> _fetchTypesCities(InstitutionsBloc bloc) async {
    final abroad = (bloc.state as InstitutionsLoaded).abroad;
    final cities = await InstitutionsRepository.instance.getCities(abroad: abroad);
    final types = await InstitutionsRepository.instance.getTypes(abroad: abroad);

    setState(() {
      _cities = cities;
      _types = types;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<InstitutionsBloc>(context);
    if (!_loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageHeader(
            title: 'filter'.i18n(),
            actionText: 'clear'.i18n(),
            onActionTap: () {
              setState(() {
                _selectedCity = null;
                _selectedType = null;
                _page = null;
                _searchText = '';
                BackButtonInterceptor.remove(_interceptor);
                bloc.add(FilterInstitutionsEvent(
                  filter: Filter(
                    city: _selectedCity,
                    type: _selectedType,
                  ),
                ));
              });
            },
            onBackAction: () {
              if (_page != null) {
                setState(() {
                  _page = null;
                  _searchText = '';
                });
                BackButtonInterceptor.remove(_interceptor);
              } else {
                MainBloc bloc = BlocProvider.of<MainBloc>(context);
                bloc.add(PopPageEvent());
              }
            },
            headerPadding: false,
          ),
          Expanded(
            child: _pageContent(context),
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _pageContent(BuildContext context) {
    switch (_page) {
      case Page.city:
        return _cityPage(context);
      case Page.type:
        return _typePage(context);
      default:
        return _mainPage(context);
    }
  }

  Widget _cityPage(BuildContext context) {
    final bloc = BlocProvider.of<InstitutionsBloc>(context);
    final cities = _cities.where((e) => e.name.toLowerCase().contains(_searchText.toLowerCase())).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: MainSearchBar(
            onChange: (text) {
              setState(() {
                _searchText = text;
              });
            },
            text: _searchText,
            hint: 'enter-institution'.i18n(),
            trailing: TextButton(
              onPressed: () {
                setState(() {
                  _searchText = '';
                });
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
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: FilterItem(
                    title: cities[index].name,
                    selected: cities[index].id == _selectedCity?.id,
                    onPressed: () {
                      setState(() {
                        _selectedCity = cities[index];
                        _searchText = '';
                        _page = null;
                        BackButtonInterceptor.remove(_interceptor);
                        bloc.add(FilterInstitutionsEvent(
                          filter: Filter(
                            city: _selectedCity,
                            type: _selectedType,
                          ),
                        ));
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _typePage(BuildContext context) {
    final bloc = BlocProvider.of<InstitutionsBloc>(context);
    final types = _types.where((e) => e.name.toLowerCase().contains(_searchText.toLowerCase())).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: MainSearchBar(
            onChange: (text) {
              setState(() {
                _searchText = text;
              });
            },
            text: _searchText,
            hint: 'enter-institution'.i18n(),
            trailing: TextButton(
              onPressed: () {
                setState(() {
                  _searchText = '';
                });
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
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: FilterItem(
                    title: types[index].name,
                    selected: types[index].id == _selectedType?.id,
                    onPressed: () {
                      setState(() {
                        _selectedType = types[index];
                        _searchText = '';
                        _page = null;
                        BackButtonInterceptor.remove(_interceptor);
                        bloc.add(FilterInstitutionsEvent(
                          filter: Filter(
                            city: _selectedCity,
                            type: _selectedType,
                          ),
                        ));
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainPage(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          FilterEntry(
            onPressed: () {
              setState(() {
                _page = Page.city;
              });
              BackButtonInterceptor.add(_interceptor);
            },
            title: 'city'.i18n(),
            selection: _selectedCity?.name ?? '',
          ),
          const SizedBox(height: 16),
          FilterEntry(
            onPressed: () {
              setState(() {
                _page = Page.type;
              });
              BackButtonInterceptor.add(_interceptor);
            },
            title: 'institution-type'.i18n(),
            selection: _selectedType?.name ?? '',
          ),
        ],
      ),
    );
  }
}

enum Page {
  city,
  type,
}
