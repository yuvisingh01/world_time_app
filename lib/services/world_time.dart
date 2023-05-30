import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;   // location name for UI
  String time='';   // the time in that location
  String flag;      // url to an asset flag icon
  String url; // location url for  api endpoint
  bool isDayTime=true;  //true or false if daytime or not

  WorldTime({required this.location,required this.flag,required this.url});
  Future<void> getTime() async {
    try {
      // Make the API request
      Response response =
      await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Parse the response
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      bool isDst = data['dst'];
      print(data);
      // Create a DateTime object
      DateTime now = DateTime.parse(datetime);

      // Parse the offset string to get hours and minutes
      int offsetHours = int.parse(offset.substring(1, 3));
      int offsetMinutes = int.parse(offset.substring(4, 6));
      // Adjust for the UTC offset
      if (offset[0] == '+') {
        now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));
      } else {
        now = now.subtract(Duration(hours: offsetHours, minutes: offsetMinutes));
      }

      // Adjust for DST
      if (isDst) {
        now = now.add(Duration(hours: 1));
      }

      // Set the time property
      isDayTime=now.hour>6 && now.hour<20?true:false;
      // Set the time value
      time = DateFormat.jm().format(now);
    } catch (error) {
      print('Error: $error');
      time='could not get time data';
      // Handle error cases if necessary
    }
  }



}

WorldTime instance=WorldTime(location:'India', flag:'img.png',url:'Asia/Kolkata');