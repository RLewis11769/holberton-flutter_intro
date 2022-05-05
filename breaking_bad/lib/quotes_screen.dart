import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'models.dart';

class QuotesScreen extends StatelessWidget {
  // final Character character;
  // ignore: prefer_typing_uninitialized_variables
  final String character;

  const QuotesScreen({Key? key, required this.character}) : super(key: key);

  Future<List> fetchQuote(String char) async {
    try {
      // if character name has spaces, replace with '+'
      final charName = char.replaceAll(' ', '+');
      // Send get request to url (parse string as uri type)
      var response = await http.get(
          Uri.parse('https://breakingbadapi.com/api/quote?author=$charName'));
      // Decode response body to json
      var quotes = json.decode(response.body);
      // Return mapping of quote object at key 'quote' converted to list
      return quotes.map((quote) => quote['quote']).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // On tap, return to parent HomeScreen widget
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Card(
          child: FutureBuilder(
              // Fetch data from url with character name
              future: fetchQuote(character),
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
                  // If empty list, provide error notification
                  if (snapshot.data.length == 0) {
                    return const Center(
                      child: Text("No quotes from this character"),
                    );
                  } else {
                    // Create list of quotes
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(snapshot.data[index]),
                          );
                        });
                  }
                }
              }),
        ),
      ),
    );
  }
}
