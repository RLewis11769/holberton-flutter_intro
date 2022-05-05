import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'character_tile.dart';
import 'quotes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  get itemHeight => null;

  get itemWidth => null;

  Future<List<Character>> fetchBbCharacters() async {
    try {
      // Send get request to url (parse string as uri type)
      var response = await http
          .get(Uri.parse('https://breakingbadapi.com/api/characters'));
      // Decode response body to json
      var characters = json.decode(response.body);
      List<Character> charList = [];
      for (var char in characters) {
        // Convert to string and add to list
        charList.add(Character.fromJson(char));
      }
      return charList;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Breaking Bad Quotes'),
        ),
        body: Card(
            child: FutureBuilder(
                // Fetch data from url
                future: fetchBbCharacters(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // If snapshot is loading, add loading widget
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // If loaded but no data returned, add error notification
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else {
                    // Create list of characters
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // Determine how many items to show in row
                          crossAxisCount: 2,
                          // Determine how wide each item is
                          childAspectRatio: (3 / 2),
                        ),
                        // Must provide total number of items
                        itemCount: snapshot.data.length,
                        // Loop through each item in snapshot.data
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              // On tap, navigate to quotes screen, passing character name
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuotesScreen(
                                            character:
                                                snapshot.data[index].name)));
                              },
                              // Character tile widget wrapped in GestureDetector for click event
                              // This is display, passing character index to character tile
                              child: Card(
                                child: CharacterTile(
                                    character: snapshot.data[index]),
                              ));
                        });
                  }
                })));
  }
}
