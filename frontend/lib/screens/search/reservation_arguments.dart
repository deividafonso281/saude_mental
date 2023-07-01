import 'package:frontend/models/especialist_model.dart';

class ReservationArguments {
  final String fullName;
  final String id;
  final String agenda;
  final String availability;
  final EspecialistModel especialist;

  ReservationArguments(this.fullName, this.id, this.agenda, this.availability, this.especialist);
}