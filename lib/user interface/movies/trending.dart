import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user%20interface/screens/movie_description.dart';

class MoviesList extends StatelessWidget {
  final List trending;

  const MoviesList({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter the list to include only items with non-null titles
    List filteredTrending =
        trending.where((item) => item['title'] != null).toList();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrending.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  String posterPath = filteredTrending[index]['poster_path'] ??
                      ''; // Use empty string if null
                  String title = filteredTrending[index]['title'] ??
                      'No Title'; // Use 'No Title' if null

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    id: trending[index]['id'].toString(),
                                    name: trending[index]['title'],
                                    description: trending[index]['overview'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w780' +
                                            trending[index]['poster_path'],
                                    genres: trending[index]['genre_ids'],
                                    vote: trending[index]['vote_average']
                                        .toString(),
                                    launch_on: trending[index]['release_date'],
                                  )));
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500' +
                                      posterPath,
                                ),
                                fit: BoxFit.cover,
                              ),
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
