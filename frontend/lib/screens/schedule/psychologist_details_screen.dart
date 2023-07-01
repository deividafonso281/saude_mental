import 'package:flutter/material.dart';
import 'package:frontend/screens/search/reservation_arguments.dart';
import 'package:frontend/utils/router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/utils/router.dart';

class PsyDetailsScreen extends StatefulWidget {
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
  final String availability;
  final especialist;

   PsyDetailsScreen({
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
     required this.availability,
     required this.especialist,
  }) : super(key: key);

  @override
  State<PsyDetailsScreen> createState() => PsyDetailsScreenState();
}

class PsyDetailsScreenState extends State<PsyDetailsScreen> {

  void _launchWhatsApp(String phoneNumber) async {
    var whatsappUrl = 'whatsapp://send?phone=$phoneNumber';
    final uri = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://pm1.aminoapps.com/6277/edc568e23b49ae8d1b98d1a821f4bc251c5b8651_00.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fullName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'CRP: ${widget.crp}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                widget.bios,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Telefone: ${widget.phoneNumber}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Email: ${widget.email}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                'Especialização: Psicologia Clínica',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.reservation_screen,
                      arguments: ReservationArguments(
                        widget.fullName,
                        widget.id,
                          widget.agenda,
                        widget.availability,
                        widget.especialist,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Solicitar consulta',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                  ElevatedButton(
                    onPressed: () {
                      _launchWhatsApp('55${widget.phoneNumber}');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Entrar em contato pelo WhatsApp',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
