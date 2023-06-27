import 'package:flutter/material.dart';
import '../schedule/psychologist_details_screen.dart';

class MyCard extends StatelessWidget {
  final String image;
  final String fullName;
  final String crp;
  final String phoneNumber;
  final String email;
  final String bios;
  final String id;
  final num latitude;
  final num longitude;
  final String agenda;

  const MyCard({
    Key? key,
    required this.image,
    required this.fullName,
    required this.crp,
    required this.phoneNumber,
    required this.email,
    required this.bios,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.agenda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PsyDetailsScreen(
              image: '',
              fullName: fullName,
              bios: bios,
              crp: crp,
              phoneNumber: phoneNumber,
              email: email,
              id: id,
              longitude: longitude,
              latitude: latitude,
              agenda: agenda,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://pm1.aminoapps.com/6277/edc568e23b49ae8d1b98d1a821f4bc251c5b8651_00.jpg', // Insira a URL da imagem desejada
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 200,
                      child:
                        Text(
                        fullName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        ),
                  )

                ],
              ),
              const SizedBox(height: 10),
              Text(
                'CRP: $crp\n$email\n$phoneNumber',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'A X Km de você',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}