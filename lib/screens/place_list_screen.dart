import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddPlaceScreen.routeName),
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(builder: (ctx, greatPlaces, ch) {
                    return greatPlaces.items.length <= 0
                        ? Center(
                            child: const Text('No places added'),
                          )
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    Provider.of<GreatPlaces>(context,
                                            listen: false)
                                        .deletePlace(
                                            greatPlaces.items[index].id);
                                  },
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[index].id);
                                },
                              );
                            });
                  });
          }),
    );
  }
}
