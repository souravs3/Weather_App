import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_project/const/weather_icon.dart';
import 'package:weather_project/controller/controller.dart';
import 'package:weather_project/view/search_page.dart';
import 'package:weather_project/view/weather_history_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a 2-second delay before showing content
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _buildLoadingScreen()
        : Consumer<WeatherDataProvider>(
            builder: (context, weatherProvider, _) {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  titleSpacing: -10,
                  elevation: 20,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.black,
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  title: Text(
                    weatherProvider.cityModel?.name ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeatherHistory(),
                          ),
                        );
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'item1',
                          child: Text('History'),
                        ),

                        // Add more items as needed, or populate dynamically based on history
                      ],
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 33, 33, 33),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-vector/sky-background-video-conferencing_23-2148623068.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Today, ${DateFormat('d MMM').format(DateTime.now())}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    '${weatherProvider.weatherData?.weather?[0].main}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Text(
                                            '${weatherProvider.weatherData?.main?.temp!.toInt()} ', // Convert to int
                                            style: const TextStyle(
                                              fontSize: 60,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Positioned(
                                            top: 0,
                                            right: -4,
                                            child: Icon(
                                              WeatherIcons
                                                  .celsius, // Assuming WeatherIcons.celsius is the correct icon
                                              color: Colors
                                                  .white, // Set icon color
                                              size:
                                                  26, // Set icon size as needed
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          ' ${weatherProvider.weatherData?.main?.tempMax!.toInt()}° / ${weatherProvider.weatherData?.main?.tempMin!.toInt()}°', // Convert to int
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              146, 113, 113, 113),
                                          child: IconButton(
                                            onPressed: () async {
                                              // Call the method to fetch weather data again
                                              await weatherProvider
                                                  .fetchWeatherData(
                                                weatherProvider
                                                        .cityModel?.lat ??
                                                    0.0,
                                                weatherProvider
                                                        .cityModel?.lon ??
                                                    0.0,
                                              );

                                              // Call the method to fetch forecast data again
                                              await weatherProvider
                                                  .fetchWeatherDataList(
                                                weatherProvider
                                                        .cityModel?.lat ??
                                                    0.0,
                                                weatherProvider
                                                        .cityModel?.lon ??
                                                    0.0,
                                              );

                                              // Trigger a rebuild of the UI
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.refresh_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 33, 33, 33),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Feel like',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  'images/noun-thermostat-20935.png',
                                                  color: Colors.white,
                                                  width: 28),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${weatherProvider.weatherData?.main?.feelsLike!.toInt()} °C',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Humidity is making it',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 40),
                                            child: Row(
                                              children: [
                                                // Replace Icons.ac_unit with the desired icon
                                                Text(
                                                  "${weatherProvider.weatherData?.weather?[0].description}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 33, 33, 33),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Wind Speed',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.air,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${weatherProvider.weatherData?.wind?.speed}km/h',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 33, 33, 33),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Humidity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset('images/water.png',
                                              color: Colors.white, width: 15),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            '${weatherProvider.weatherData?.main?.humidity} %',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Forecast Data Container
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 33, 33, 33),
                              borderRadius: BorderRadius.all(
                                Radius.circular(26),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '5 day Forecast',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<WeatherDataProvider>(
                                  builder: (context, weatherProvider, _) {
                                    final weatherDataList =
                                        weatherProvider.weatherDataList;

                                    if (weatherDataList != null &&
                                        weatherDataList.length >= 5) {
                                      // Sort the weather data list by date
                                      weatherDataList.sort(
                                          (a, b) => a.dtTxt.compareTo(b.dtTxt));

                                      return Column(
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 13,
                                                      horizontal: 20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      WeatherIcon(
                                                        description:
                                                            weatherDataList[i]
                                                                .weather[0]
                                                                .main,
                                                        width: 24,
                                                      ),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        // Format the date from the forecast data into abbreviated day names
                                                        DateFormat('EEEE')
                                                            .format(
                                                          DateTime.now().add(
                                                            Duration(
                                                                days: i + 1),
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        weatherDataList[i]
                                                            .weather[0]
                                                            .main,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        // Display the max and min temperatures
                                                        '${weatherDataList[i].main.tempMax.round()}° / ${weatherDataList[i].main.tempMin.round()}°',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      );
                                    } else {
                                      // If forecast list is null or doesn't have enough data, display a message
                                      return const Text(
                                          'Not enough forecast data available');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
