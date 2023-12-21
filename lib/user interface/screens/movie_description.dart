import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_tickets_task/user%20interface/screens/ticketsPages/tickets_page.dart';
import 'package:movies_tickets_task/user%20interface/screens/watch_screen.dart';
import 'package:movies_tickets_task/user%20interface/themes/colors.dart';
import 'package:movies_tickets_task/models/genre_model.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/video_player.dart';

class Description extends StatefulWidget {
  const Description({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch_on,
    required this.genres,
  }) : super(key: key);

  final String id, name, description, bannerurl, posterurl, vote, launch_on;
  final List<dynamic> genres;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late List<String> genreNames;
  late List<dynamic> videos;
  String key = "";

  YoutubePlayerController _youtubeController = YoutubePlayerController(
    initialVideoId:
        'YOUR_INITIAL_VIDEO_ID', // Placeholder value, it will be replaced dynamically
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  List<String> getGenreNames(List<dynamic> genreIds) {
    return genreIds.map((id) => Genre.getCategoryById(id)).toList();
  }

  Future<void> fetchMovieVideos() async {
    final String apiKey = "276110cc6e09716ff6c45f16fa626c5c";
    final String apiUrl =
        "http://api.themoviedb.org/3/movie/${widget.id}/videos?api_key=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if 'results' is a list
        if (data['results'] is List) {
          setState(() {
            videos = data['results'];
            key = videos[0]['key'];
          });
        } else {
          throw Exception('Invalid response format: Results is not a list');
        }
      } else {
        throw Exception('Failed to load movie videos');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load movie videos');
    }
  }

  @override
  void initState() {
    super.initState();
    genreNames = getGenreNames(widget.genres);
    fetchMovieVideos();
    videos = [];
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genreNames = getGenreNames(widget.genres);
    print(widget.id);
    print("keyyyyy");
    print(key);
    final formattedLaunchOn =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.launch_on));

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.posterurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 10,
                            blurRadius: 8,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 24,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "In Theatres $formattedLaunchOn",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TicketsScreen(
                                      title: this.widget.name.toString(),
                                      release: formattedLaunchOn,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGetTickets,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: Size(220, 50),
                              ),
                              child: const Text(
                                "Get Tickets",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerPage(key),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: BorderSide(color: kGetTickets),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: Size(220, 50),
                              ),
                              icon: const Icon(
                                Icons.play_arrow,
                              ),
                              label: const Text(
                                "Watch Trailer",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
                  child: Text(
                    "Genres",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: genreNames.map((genreName) {
                      return Chip(
                        label: Text(
                          genreName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: getRandomColor(),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 8.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}
