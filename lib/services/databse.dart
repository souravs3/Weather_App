// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_project/controller/controller.dart';

// class WeatherHistory extends StatelessWidget {
//   const WeatherHistory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final weatherProvider = Provider.of<WeatherDataProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leadingWidth: 25,
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: const Text(
//           'History',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Historical Weather',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: weatherProvider.getCurrentWeather(
//                   weatherProvider.searchedCities[0].cityName),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: weatherProvider.searchedCities.length,
//                     itemBuilder: (context, index) {
//                       final city = weatherProvider.searchedCities[index];
//                       return Column(
//                         children: [
//                           ListTile(
//                             title: Text(
//                               city.cityName,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             subtitle: Text(
//                               '${city.temperature.toInt()}°C',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const Divider(
//                             color: Colors.white,
//                             height: 1,
//                             thickness: 1,
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
