import 'package:dio/dio.dart';
import 'package:sahayatri/Helper_Classes/config_helper.dart';
import 'dart:convert' as convert;

import 'package:sahayatri/Map_Classes/search_place.dart';

class PlaceService{

  Future<List<SearchPlace>> autoComplete(String input) async{
    Map<String, dynamic> config = await renderConfigFile();
    var lat = 35;
    var lng = 139;
    
    // var response = await Dio().get('{$config[\'map_api\']}?input={$input}&key={$config[\'google_place_url\']}');

    // var json = convert.jsonDecode(response.data);

    // ?lat=35&lon=139&appid=b568bcee95e152df1f6293f8a215b65f

    var response = await Dio().get('{$config[\'weather_url\']}?lat={$lat}&lon={$lng}&appid={$config[\'weather_api\']}');

    var json = convert.jsonDecode(response.data);

    var results = json['description'] as List;
    print(results.map((e) => SearchPlace.fromJson(e)).toList());
    return results.map((e) => SearchPlace.fromJson(e)).toList();
  }
}