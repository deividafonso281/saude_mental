import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/search/common.dart';
import 'package:frontend/screens/search/psychologist_card.dart';
import 'package:provider/provider.dart';

import '../../models/especialist_model.dart';

class CardList extends StatefulWidget {
  final Stream<List<EspecialistModel>> items;

  const CardList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CardList> createState() => CardListState();
}

class CardListState extends State<CardList> {
  final String checkEmptyMessage = "Nenhum resultado foi encontrado";

  String? checkIsEmpty(List? cardList) {
    return (cardList == null || cardList.isEmpty) ? checkEmptyMessage : null;
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return StreamBuilder<List<EspecialistModel>>(
      stream: widget.items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<EspecialistModel>? specialistList = snapshot.data;
          List<Widget> cardList = [];

          if (specialistList == null || specialistList.isEmpty) {
            return const Text(
              "Nenhum resultado foi encontrado para a sua busca",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            );
          }

          for (EspecialistModel item in specialistList) {
            String image = 'item.image';
            String fullName = item.fullName;
            String bios = item.bios;
            String crp = item.CRP;
            String phoneNumber = item.phoneNumber;
            String email = item.email;
            String id = item.id;
            double latitude = item.latitude;
            double longitude = item.longitude;
            double dist = calculateDistance(
                latitude, longitude, userModel.latitude, userModel.longitude);

            cardList.add(
              MyCard(
                image: image,
                fullName: fullName,
                bios: bios,
                crp: crp,
                phoneNumber: phoneNumber,
                email: email,
                id: id,
                longitude: longitude,
                latitude: latitude,
                distance: dist,
              ),
            );
          }

          return Column(
            children: cardList,
          );
        } else if (snapshot.hasError) {
          return Text('Ocorreu um erro: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
//
// class CardListState extends State<CardList> {
//
//   final String checkEmptyMessage = "Nenhum resultado foi encontrado";
//
//   String? checkIsEmpty(List? cardList) {
//     return (cardList == null || cardList.isEmpty) ? checkEmptyMessage : null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<EspecialistModel> cardList = [];
//
//     for (EspecialistModel item in widget.items) {
//       String image = 'item.image';
//       String fullName = item.fullName;
//       String bios = item.bios;
//       String CRP = item.CRP;
//       String phoneNumber = item.phoneNumber;
//       String email = item.email;
//       String id = item.id;
//       cardList.add(
//         MyCard(image: image, fullName: fullName, bios: bios, CRP: CRP, phoneNumber: phoneNumber, email: email, id: id),
//       );
//     }
//
//     if (checkIsEmpty(cardList) == checkEmptyMessage) {
//       return const Text(
//         "Nenhum resultado foi encontrado para a sua busca",
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 18),
//       );
//     }
//
//     return Column(
//       children: cardList,
//     );
//   }
// }
