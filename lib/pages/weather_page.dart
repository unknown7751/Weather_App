import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{
  
  //api key
  final _weatherService = WeatherService('YOUR_API_KEY');
  Weather? _weather;
  
  //fetch weather
  _fetchWeather() async{
    // get current city 
    String cityName = await _weatherService.getCurrentCity();
    //get weather city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;

      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null){
      return 'assets/sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'sunny':
        return 'assets/sunny.json';
      case 'clear':
        return 'assets/clear_night.json';
      case 'partly cloudy':
        return 'assets/partly_cloudy.json';
      case 'cloudy':
        return 'assets/cloudy.json';
      case 'overcast':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/cloud_mist.json';
      case 'fog':
        return 'assets/cloud_mist.json';
      case 'freezing fog':
        return 'assets/cloud_mist.json';
      case 'patchy rain possible':
        return 'assets/rain_night.json';
      case 'patchy light drizzle':
        return 'assets/rain_night.json';
      case 'light drizzle':
        return 'assets/rain_night.json';
      case 'patchy light rain':
        return 'assets/rain_night.json';
      case 'light rain':
        return 'assets/rain_night.json';
      case 'light rain shower':
        return 'assets/rain_night.json';
      case 'moderate rain at times':
        return 'assets/heavy_rain.json';
      case 'moderate rain':
        return 'assets/heavy_rain.json';
      case 'heavy rain at times':
        return 'assets/heavy_rain.json';
      case 'heavy rain':
        return 'assets/heavy_rain.json';
      case 'moderate or heavy rain shower':
        return 'assets/heavy_rain.json';
      case 'torrential rain shower':
        return 'assets/heavy_rain.json';
      case 'patchy snow possible':
        return 'assets/snow_day.json';
      case 'patchy moderate snow':
        return 'assets/snow_day.json';
      case 'moderate snow':
        return 'assets/snow_day.json';
      case 'patchy heavy snow':
        return 'assets/snow_day.json';
      case 'heavy snow':
        return 'assets/snow_day.json';
      case 'light snow':
        return 'assets/snow_day.json';
      case 'light snow showers':
        return 'assets/snow_night.json';
      case 'moderate or heavy snow showers':
        return 'assets/snow_night.json';
      case 'patchy sleet possible':
        return 'assets/cloudy.json';
      case 'patchy freezing drizzle possible':
        return 'assets/cloudy.json';
      case 'freezing drizzle':
        return 'assets/cloudy.json';
      case 'heavy freezing drizzle':
        return 'assets/cloudy.json';
      case 'light freezing rain':
        return 'assets/cloudy.json';
      case 'moderate or heavy freezing rain':
        return 'assets/cloudy.json';
      case 'light sleet':
        return 'assets/cloudy.json';
      case 'moderate or heavy sleet':
        return 'assets/cloudy.json';
      case 'blowing snow':
        return 'assets/snow_day.json';
      case 'blizzard':
        return 'assets/snow_day.json';
      case 'ice pellets':
        return 'assets/snow_night.json';
      case 'light showers of ice pellets':
        return 'assets/snow_night.json';
      case 'moderate or heavy showers of ice pellets':
        return 'assets/snow_night.json';
      case 'thundery outbreaks possible':
        return 'assets/thunder.json';
      case 'patchy light rain with thunder':
        return 'assets/thunder.json';
      case 'moderate or heavy rain with thunder':
        return 'assets/thunder.json';
      case 'patchy light snow with thunder':
        return 'assets/thunder.json';
      case 'moderate or heavy snow with thunder':
        return 'assets/thunder.json';
      default:
        return 'assets/cloudy.json';
    }


  }

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  fetch weather on strtup
    _fetchWeather();
  }
  
  
  @override
  Widget build(BuildContext context){
    Color bgColor = Colors.black;
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
        backgroundColor: bgColor, // Set AppBar color to match
        elevation: 0, // Remove shadow for a seamless look
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //City name
            Text(_weather?.cityName ?? "city..",
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 255, 255, 255)  
                  ),),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}°C',
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 59,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 255, 255, 255)  
                  ),
                  ),
            
            Text('${_weather?.mainCondition}',
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 255, 255, 255)  
                  ),),
          ],
      ),
      ),
    );
  }
}