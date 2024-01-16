import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/user_interface/screens/genre_list.dart';
import '../bottom_navbar/navbar.dart';
import '../themes/colors.dart';
import 'package:provider/provider.dart';

class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({Key? key}) : super(key: key);

  @override
  State<MediaLibraryPage> createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> {
  late String apikey;
  late MovieProvider movieProvider;
  final readaccesstoken = "";
  final bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    apikey = dotenv.env['API_KEY'] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: kAppBarBackgroundColor,
          title: const Text(
            'Discover',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                // Create a Card for each genre
                const SizedBox(height: 20.0), // Add spacing
                buildGenreCard('Action', '28', movieProvider, 'assets/mi.jpg'),
                const SizedBox(height: 20.0), // Add spacing

                buildGenreCard(
                    'Adventure', '12', movieProvider, 'assets/hobbit.jpg'),
                const SizedBox(height: 20.0), // Add spacing

                buildGenreCard(
                    'Comedy', '35', movieProvider, 'assets/friends.jpg'),
                const SizedBox(height: 20.0), // Add spacing

                buildGenreCard(
                    'Horror', '27', movieProvider, 'assets/horror.jpg'),
                const SizedBox(height: 20.0), // Add spacing

                buildGenreCard(
                    'Romance', '10749', movieProvider, 'assets/lalaland.jpg'),
                const SizedBox(height: 20.0), // Add spacing

                buildGenreCard(
                    'Animation', '16', movieProvider, 'assets/up.jpg'),
              ],
            ),
          ),
          const SizedBox(height: 5.0), // Add spacing
        ],
      ),
      bottomNavigationBar: const CustomNavBar(
        curr_index: 2,
      ),
    );
  }

  Card buildGenreCard(
      String genreName, String genreId, MovieProvider provider, String image) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () async {
          setState(() {
            provider.loadgenreMovies(genreId: genreId);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenreScreen(
                  genreMovies: genreId,
                  genreName: genreName,
                ),
              ),
            );
          });
        },
        child: Container(
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    genreName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
