import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RadioResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RecitersResponseModel.dart';
import 'package:islami/features/home/tabs/TimeTab/data/models/PrayerResponseModel.dart';

class ApiManager{
  static Future<RadioResponseModel>getRadioData()async{
    try{
      Uri uri = Uri.parse('https://www.mp3quran.net/api/v3/radios?language=ar');
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

  static Future<PrayerResponseModel>getPrayerDate()async{
    try{
      var date = DateFormat('dd-MM-YYYY').format(DateTime.now());
      Uri uri = Uri.parse('https://api.aladhan.com/v1/timingsByCity/$date?city=alex&country=egypt');
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return PrayerResponseModel.fromJson(jsonResponse);
    }catch(e){
      throw e;
    }
  }
}