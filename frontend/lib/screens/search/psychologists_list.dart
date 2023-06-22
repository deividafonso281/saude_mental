import 'package:flutter/material.dart';
import 'package:frontend/screens/search/psychologist_card.dart';


class CardList extends StatefulWidget {
  final List<List<String>> items;

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
    List<Widget> cardList = [];

    for (List<String> item in widget.items) {
      String image = item[0];
      String nomePsi = item[1];
      String biosPsi = item[2];
      String distPsi = item[3];
      cardList.add(
        MyCard(image: image, text1: nomePsi, text2: biosPsi, text3: distPsi),
      );
    }

    if (checkIsEmpty(cardList) == checkEmptyMessage) {
      return const Text(
        "Nenhum resultado foi encontrado para a sua busca",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      );
    }

    return Column(
      children: cardList,
    );
  }
}
