import 'package:flutter/material.dart';
import 'package:flutter_multi_app/loading/loading_home.dart';
import 'package:flutter_multi_app/map/flutter_map_view.dart';
import 'package:flutter_multi_app/rive/flutter_rive_view.dart';

class AppViews {
  static const List<Widget> views = [
    FlutterMapView(title: 'FlutterMapView'),
    FlutterRiveView(title: 'FlutterRiveView'),
    LoadingHome(title: 'FlutterLoadingRive'),
  ];
}
