import 'package:flutter/material.dart';
import 'package:real_estate_viewer/models/apartment_model.dart';
import 'package:real_estate_viewer/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ApartmentModel> futureApartment;

  @override
  void initState() {
    super.initState();
    futureApartment = ApiServices().fetchApartmentList();
  }

  Widget _buildApartmentCard(Item item) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text(''),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: futureApartment,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return showFutureError();
          } else {
            final result = snapshot.data;

            ApartmentModel apartmentResult = result;
            List<Item> apartmentList = apartmentResult.response.body.items.item;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: ListView.builder(
                        itemCount: apartmentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildApartmentCard(apartmentList[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget showFutureError() => SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: const Text('Error'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
}
