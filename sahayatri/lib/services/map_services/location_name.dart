import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationName extends ChangeNotifier {
  bool _origin = false;
  bool _destination = false;

  String? _originName = 'Origin';
  String? _destinationName = 'Destination';

  String get originName => _originName!;
  String get destinationName => _destinationName!;

  bool get getOrigin => _origin;
  bool get getDestinaion => _destination;

  void origin({required LatLng latLng}) async {
    _originName = await getAddress(latLng.latitude, latLng.longitude);
    _origin = true;
    notifyListeners();
  }

  void destination({required LatLng latLng}) async {
    _destinationName = await getAddress(latLng.latitude, latLng.longitude);
    _destination = true;
    notifyListeners();
  }

  void initialState(){
    this._originName = 'Origin';
    this._destinationName = 'destination';
    this._origin = false;
    this._destination = false;
    notifyListeners();
  }

  Future<String?> getAddress(double lat, double lng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lng, localeIdentifier: 'en_UK');
    Placemark np = placemarks[0];
    String? name = np.name;
    String? subLocality = np.subLocality;
    String? locality = np.locality;
    String address = '$name, $subLocality, $locality';
    return address;
  }
}
