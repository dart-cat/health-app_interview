import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class CachedTileProvider extends TileProvider {
  CachedTileProvider({super.headers});

  @override
  ImageProvider getImage(Coords<num> coords, TileLayer options) {
    if (options.urlTemplate != null) {
      String url = options.urlTemplate!;
      url = url.replaceFirst('{x}', coords.x.toStringAsFixed(0));
      url = url.replaceFirst('{y}', coords.y.toStringAsFixed(0));
      url = url.replaceFirst('{z}', coords.z.toStringAsFixed(0));
      return CachedNetworkImageProvider(url);
    }
    throw ArgumentError('Specify urlTemplate!');
  }
}
