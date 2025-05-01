import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_multi_app/custom_app_bar.dart';
import 'package:flutter_multi_app/model/marker_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class FlutterMapView extends StatefulWidget {
  const FlutterMapView({super.key});

  @override
  State<FlutterMapView> createState() => _FlutterMapViewState();
}

class _FlutterMapViewState extends State<FlutterMapView> with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController = AnimatedMapController(vsync: this);

  List<MarkerData> _markerData = [];
  List<Marker> _markers = [];
  LatLng? _selectedPosition;
  LatLng? _mylocation;
  LatLng? _draggedPotition;
  bool _isDragging = false;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  FocusNode _focusNode = FocusNode();

  // get current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, so we can't get the location.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, so we can't get the location.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied, so we can't get the location.
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  // show current Location
  void _showCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _mylocation = currentLatLng;
        _animatedMapController.animateTo(dest: currentLatLng);
      });
    } catch (e) {
      // Handle the error
      print('Error getting location: $e');
    }
  }

  // add marker
  void _addMarker(LatLng position, String title, String description) {
    setState(() {
      final markerData = MarkerData(position: position, title: title, description: description);
      _markerData.add(markerData);
      _markers.add(
        Marker(
          point: position,
          width: 120,
          height: 80,
          child: GestureDetector(
            onTap: () => _showMarkerInfo(context, markerData),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // show marker dialog
  void _showMarkerDialog(BuildContext context, LatLng position) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Marker'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addMarker(position, _titleController.text, _descController.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // show marker info when tapped
  // i am creating just simple you can alos add more features and make it more Funtcional.
  void _showMarkerInfo(BuildContext context, MarkerData markerData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(markerData.title),
          content: Text(markerData.description),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }

  // search feature
  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data.isNotEmpty) {
      setState(() {
        _searchResults = data;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  // move to specific Location
  void _moveToLocation(double lat, double lon) {
    LatLng newLocation = LatLng(lat, lon);
    _animatedMapController.animateTo(dest: newLocation);
    setState(() {
      _selectedPosition = newLocation;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  // unfocus text field
  void _unfocusTextField() {
    _focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchPlaces(_searchController.text);
    });
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    _searchController.dispose();
    _focusNode.dispose(); // 忘れずに解放！
    super.dispose();
  }

  TileLayer get tileLayer => TileLayer(urlTemplate: 'http://tile.openstreetmap.org/{z}/{x}/{y}.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              // you can set the initial position of the map here
              // Here is Tokyo Station.
              initialCenter: LatLng(35.680585, 139.767286),
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 10.0,
              onTap: (tapPosition, point) {
                _unfocusTextField();

                setState(() {
                  _isSearching = false;

                  _selectedPosition = point;
                  _draggedPotition = _selectedPosition;
                });
              },
            ),
            children: [
              tileLayer,
              MarkerLayer(
                markers: _markers,
              ),
              if (_isDragging && _draggedPotition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _draggedPotition!,
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                    )
                  ],
                ),
              if (_mylocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _mylocation!,
                      child: Icon(
                        Icons.my_location,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                    ),
                  ],
                )
            ],
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            child: Column(
              children: [
                TextFormField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _isSearching
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _unfocusTextField();
                              setState(() {
                                _isSearching = false;
                                _searchResults = [];
                              });
                            },
                            icon: Icon(Icons.clear))
                        : null,
                  ),
                  onTap: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
                if (_isSearching && _searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final place = _searchResults[index];
                        return ListTile(
                          title: Text(place['display_name']),
                          onTap: () {
                            final lat = double.parse(place['lat']);
                            final lon = double.parse(place['lon']);
                            _moveToLocation(lat, lon);
                          },
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
          if (!_isDragging)
            Positioned(
              left: 20,
              bottom: 20,
              child: SafeArea(
                child: FloatingActionButton(
                  heroTag: 'add_location',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isDragging = true;
                    });
                  },
                  child: Icon(Icons.add_location),
                ),
              ),
            )
          else
            Positioned(
              left: 20,
              bottom: 20,
              child: SafeArea(
                child: FloatingActionButton(
                  heroTag: 'cancel_location',
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isDragging = false;
                    });
                  },
                  child: Icon(Icons.wrong_location),
                ),
              ),
            ),
          Positioned(
            right: 20,
            bottom: 20,
            child: SafeArea(
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'current_location',
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    onPressed: _showCurrentLocation,
                    child: Icon(Icons.my_location),
                  ),
                  if (_isDragging)
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: FloatingActionButton(
                        heroTag: 'current_location',
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        onPressed: () {
                          // adding marker
                          if (_draggedPotition != null) {
                            _showMarkerDialog(context, _draggedPotition!);
                          }
                          setState(() {
                            _isDragging = false;
                            _draggedPotition = null;
                          });
                        },
                        child: Icon(Icons.check),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
