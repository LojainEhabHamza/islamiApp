import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islami/features/home/tabs/RadioTab/data/models/RadioResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RecitersResponseModel.dart';

class ApiManager{
  static Future<RadioResponseModel>getRadioData()async{
    try{
      Uri uri = Uri.parse('https://mp3quran.net/api/v3/radios?language=ar');
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RadioResponseModel.fromJson(jsonResponse);
    }catch(e){
      throw e;
    }
  }

  static Future<RecitersResponseModel>getRecitersData()async{
    try{
      Uri uri = Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=ar');
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RecitersResponseModel.fromJson(jsonResponse);
    }catch(e){
      throw e;
    }
  }
}