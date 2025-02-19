// import 'package:flutter/material.dart';
// import 'package:kira/models/files.dart';

// void main() {
//   runApp(HomePage());
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Box> categories = [];
//   void _getfiles() {
//     categories = Box.getfiles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _getfiles();
//     final _maxLength = 20;
//     final _maxLength2 = 14;

//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 222, 225, 226),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 222, 225, 226),
//         title: Container(
//             margin: EdgeInsets.only(
//               left: 4,
//             ),
//             child: Text(
//               'KIRA',
//               style: TextStyle(
//                 fontSize: 50,
//                 fontFamily: 'fonts',
//                 color: Color(0xFF11212D),
//               ),
//             )),
//         actions: [
//           Container(
//             margin: EdgeInsets.only(
//               right: 22,
//             ),
//             width: 49,
//             height: 41,
//             child: Image(
//               image: AssetImage('assests/images/menu.png'),
//               color: Colors.white,
//             ),
//             decoration: BoxDecoration(
//                 color: Color(0xFF11212D),
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ],
//       ),
//       body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 46.0),
//           child: Container(
//               child: Column(children: [
//             TextField(
//                 maxLength: _maxLength,
//                 style: TextStyle(
//                     fontSize: 28, fontFamily: 'text', color: Color(0xFF11212D)),
//                 decoration: InputDecoration(
//                     hintText: 'Give Name',
//                     counterText: '',
//                     border: OutlineInputBorder(borderSide: BorderSide.none),
//                     suffixIcon: Container(
//                         width: 100,
//                         child: IntrinsicHeight(
//                             child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                               Icon(
//                                 Icons.add,
//                                 size: 30,
//                                 color: Color(0xFF11212D),
//                               ),
//                             ]))))),
//             Container(
//               height: 210,
//               child: ListView.separated(
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.only(left: 22, right: 22),
//                       width: 164,
//                       decoration: BoxDecoration(
//                           color: categories[index].bgColor,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text('but files here'),
//                           Container(
//                               margin: EdgeInsets.only(left: 20),
//                               child: TextField(
//                                   maxLength: _maxLength2,
//                                   style: TextStyle(
//                                       fontSize: 20, color: Color(0xFF11212D)),
//                                   decoration: InputDecoration(
//                                       hintText: 'Give Name',
//                                       counterText: '',
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)))),
//                           Container(
//                             width: 90,
//                             height: 48,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xFF11212D),
//                                   Color.fromARGB(255, 74, 93, 100)
//                                 ]),
//                                 borderRadius: BorderRadius.circular(55)),
//                             child: Text(
//                               'Read',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 171, 178, 181)),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   scrollDirection: Axis.horizontal,
//                   separatorBuilder: (context, index) => SizedBox(
//                         width: 1,
//                       ),
//                   itemCount: categories.length),
//             )
//           ]))),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: Color(0xff11212D),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 33,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Recommendations',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> recommendations = [];

  void fetchMovies() async {
    try {
      final result = await fetchRecommendations(_controller.text);
      setState(() {
        recommendations = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 225, 226),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 225, 226),
        title: Container(
            margin: EdgeInsets.only(
              left: 4,
            ),
            child: Text(
              'MOVIO',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'fonts',
                color: Color(0xFF11212D),
              ),
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: 22,
            ),
            width: 40,
            height: 35,
            child: Image(
              image: AssetImage('assests/images/menu.png'),
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Color(0xFF11212D),
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(6), // Adjust outer spacing
            padding: EdgeInsets.symmetric(
                horizontal: 8), // Inner padding for better alignment
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 255, 255, 255), // Background color of the search box
              borderRadius: BorderRadius.circular(9), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  blurRadius: 5, // Shadow softness
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
              border: Border.all(
                color: Colors.grey.shade300, // Border color
                width: 0.5, // Border thickness
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      fontSize: 14, // Smaller text size
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10), // Padding inside the box
                      hintText: 'Search...', // Placeholder text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15, // Placeholder font size
                      ),
                      border: InputBorder.none, // Remove default border
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 22, // Search icon size
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Space between TextField and the button
                ElevatedButton(
                  onPressed: () {
                    fetchMovies();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF11212D), // Button color
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          6), // Rounded corners for the button
                    ),
                  ),
                  child: Text(
                    'Find',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15, // Button text size
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final movie = recommendations[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    children: [
                      // First container: Image
                      Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: movie['poster_url'] != null &&
                                  movie['poster_url']!.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(movie['poster_url']!),
                                )
                              : null,
                          color: Colors.grey, // Fallback background color
                        ),
                        child: movie['poster_url'] == null ||
                                movie['poster_url']!.isEmpty
                            ? Center(
                                child: Text('No Image',
                                    style: TextStyle(color: Colors.white)))
                            : null,
                      ),

                      SizedBox(width: 16),

                      // Second container: Name and Rating
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'] ?? 'Unknown Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    movie['rating'] ?? 'N/A',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
