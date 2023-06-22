import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PsyDetailsScreen extends StatefulWidget {
  final String parametro1;
  final int parametro2;

  const PsyDetailsScreen({Key? key, required this.parametro1, required this.parametro2}) : super(key: key);

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
                        widget.parametro1,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        'CRP: XXXX-XXX',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Olá! Prazer, meu nome é Kenma! Formado pela PUCCAMP em 2002, sou psicólogo na área esportiva a mais de 20 anos e tenho maior afinidade com teoria comportamental. Espero poder ajudar e fico a disposição!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                'Atende virtualmente? SIM',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                'Endereço do consultório: Av. Albert Einstein, 1251 - Cidade Universitária, Campinas - SP, 13083-852.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                'Especializações:',
                style: TextStyle(fontSize: 16),
              ),
              Flexible(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Text(
                        'Item $index',
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launchWhatsApp('5511970342568');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
