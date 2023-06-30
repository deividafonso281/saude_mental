import 'dart:convert';
import 'package:frontend/models/especialist_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/search/reservation_arguments.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';
import 'package:frontend/providers/auth/auth_provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  late TextEditingController newTime = TextEditingController();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  int _confirmed = 0;
  int _loaded = 0;
  List<List<String>> _agenda = [[]];
  List<List<String>> _availability = [[]];

  Column _timesAvailable = Column();

  Future<int?> _confirmDialog(BuildContext context, DateTime day, String hour) {
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deseja confirmar seu agendamento no dia '
              '${day.day.toString().padLeft(2,'0')}/'
              '${day.month.toString().padLeft(2,'0')}/'
              '${day.year.toString()}'
              ' às $hour'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context,1),
                _confirmationDialog(context)
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context,0);
              },
              child: const Text('Não'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmationDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('O agendamento foi realizado com sucesso.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context,1);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _addNewTime(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Digite o novo horário de atendimento'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: '11:30'),
            controller: newTime,
          ),
          actions: <Widget>[

            TextButton(
              onPressed: () => {
                Navigator.pop(context,newTime.text),
              },
              child: const Text('Adicionar horário'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final authModel = Provider.of<AuthModel>(context);

    final args = ModalRoute.of(context)!.settings.arguments as ReservationArguments;
    String novoHorario;
    var agenda = jsonDecode(args.agenda);
    var availability = jsonDecode(args.availability);
    for (int i=0; i<32;i++){
      agenda[i] = List<String>.from(agenda[i]);
      availability[i] = List<String>.from(availability[i]);
    }
    if (_loaded == 0) {
      _agenda = List<List<String>>.from(agenda);
      _availability = List<List<String>>.from(availability);
      _loaded = 1;
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Safe Mind"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(title: Text("Reserva de horário com profissional ${args.fullName}"),),
            TableCalendar(
              focusedDay: _focusedDay!,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                  DateTime.now().year,
                  (DateTime.now().month+1)%12,
                  DateTime.now().day-1),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  if (authModel.uid != args.id) {
                    _timesAvailable =
                        Column(
                            children: [
                              ..._availability[selectedDay.day].map(
                                      (String text) =>
                                      Card(
                                        child: ListTile(
                                            title: Text(text),
                                            onTap: () async {
                                              _confirmed =
                                              (await _confirmDialog(
                                                  context, selectedDay, text))!;
                                              if (_confirmed == 1) {
                                                setState(() {
                                                  _availability[selectedDay.day].remove(text);
                                                  _agenda[selectedDay.day].add(text);
                                                  _agenda[selectedDay.day].sort((a, b){ //sorting in ascending order
                                                    return a.compareTo(b);
                                                  });
                                                });
                                              }
                                            }
                                        ),
                                      )),
                            ]
                        );
                  }
                  else {
                    _timesAvailable =
                        Column(
                            children: [
                              ..._availability[_selectedDay.day].map(
                                      (String text) =>
                                      Card(
                                        child: ListTile(
                                            title: Text(text),
                                        ),
                                      )),
                              const ListTile(title: Text("Digite um novo horário para adicionar"),),
                              TextField(
                                autofocus: true,
                                decoration: const InputDecoration(hintText: '11:30'),
                                controller: newTime,
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    novoHorario = newTime.text;
                                    if (novoHorario.isNotEmpty && !_availability[_selectedDay.day].contains(novoHorario)) {
                                      _availability[_selectedDay.day].add(
                                          novoHorario);
                                      _availability[selectedDay.day].sort((a, b){ //sorting in ascending order
                                        return a.compareTo(b);
                                      });
                                    }
                                  });
                                  newTime.clear();

                                },
                                child: const Text('Adicionar novo horário'),
                              ),
                            ]
                        );
                  }
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
             ),
            _timesAvailable,
            TextButton(onPressed: () async {
              final firestoreDao = FirestoreDao<EspecialistModel>();

              await firestoreDao.setData(
                EspecialistModel(
                    id: authModel.uid,
                    email: args.especialist.email,
                    fullName: args.especialist.fullName,
                    gender: args.especialist.gender,
                    phoneNumber: args.especialist.phoneNumber,
                    latitude: args.especialist.latitude,
                    longitude: args.especialist.longitude,
                    address: args.especialist.address,
                    agenda: jsonEncode(_agenda),
                    CRP: args.especialist.CRP,
                    bios: args.especialist.bios,
                    especialization: args.especialist.especialization,
                    availability: jsonEncode(_availability)
                ),
              );

            }, child: const Text('Salvar mudanças')),
            ],
        ),
      ),
    );
  }
}