import 'package:flutter/material.dart';
import 'package:frontend/screens/search/reservation_arguments.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend/utils/reservation_parameters.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  DateTime? _selectedDay = DateTime.now();
  DateTime? _focusedDay = DateTime.now();
  List<String> _possiblyChosen= [];
  final List<List<String>> _availableTimes = List.generate(32, (i)=>[]);

  Column _timesAvailable = Column();

  Future<void> _confirmDialog(BuildContext context, DateTime day, String hour) {
    return showDialog<void>(
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
                Navigator.pop(context),
                _confirmationDialog(context)
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  void initState() {
    //for (var i = 0; i< 33; i++) {
    //  _availableTimes.add([]);
    //}
    _possiblyChosen = _availableTimes.elementAt(1);
    _possiblyChosen.add('14:30');
    _possiblyChosen = _availableTimes.elementAt(2);
    _possiblyChosen.add('15:30');

    //adding item to list, you can add using json from network
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

<<<<<<< HEAD
    final args = ModalRoute.of(context)!.settings.arguments as ReservationArguments;
=======
    final args = ModalRoute.of(context)!.settings.arguments as ReservationParameters;
>>>>>>> 838e2d5 (Added navigation and parameter passing to Reservation screen.)

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
<<<<<<< HEAD
            ListTile(title: Text("Reserva de horário com profissional ${args.fullName}"),),
=======
            ListTile(title: Text('Agendamento com profissional ${args.name}'),),
>>>>>>> 838e2d5 (Added navigation and parameter passing to Reservation screen.)
            TableCalendar(
              focusedDay: _focusedDay!,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                  DateTime.now().year,
                  DateTime.now().month+1,
                  DateTime.now().day-1),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _timesAvailable =
                      Column(
                        children: [
                        ..._availableTimes[selectedDay.day].map(
                                (String text) => Card(
                                  child:ListTile(
                                  title: Text(text),
                                  onTap: () => _confirmDialog(context, selectedDay, text)
                                  ),
                                )),
                        ]
                      );
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              //eventLoader: (day) {
              //  return _availableTimes[day.day];
              //},
             ),
            _timesAvailable,
            ],
        ),
      ),
    );
  }
}