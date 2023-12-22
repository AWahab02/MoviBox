import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user%20interface/screens/movie_description.dart';

class MoviesListOffline extends StatelessWidget {
  final List listofMovies;

  const MoviesListOffline({Key? key, required this.listofMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter the list to include only items with non-null titles
    List filteredlistofMovies = listofMovies;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredlistofMovies.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  String posterPath = ""; // Use empty string if null
                  String title = filteredlistofMovies[index].original_title ??
                      'No Title'; // Use 'No Title' if null

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  id: listofMovies[index].id.toString(),
                                  name: listofMovies[index].original_title,
                                  description: listofMovies[index].overview,
                                  bannerurl: "",
                                  posterurl: "",
                                  genres: [],
                                  vote: "",
                                  launch_on:
                                      listofMovies[index].release_date)));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ListTile(
                                  title: Text(
                                    title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0), // Add vertical spacing
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
