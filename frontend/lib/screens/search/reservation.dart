import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Agendamento> createState() => AgendamentoState();
}

class AgendamentoState extends State<Agendamento> {
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