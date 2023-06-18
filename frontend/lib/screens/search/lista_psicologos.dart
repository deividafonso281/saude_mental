import 'package:flutter/material.dart';
import 'package:frontend/screens/search/card_psicologo.dart';


class CardList extends StatefulWidget {
  final List<List<String>> items;

  const CardList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {

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

    return Column(
      children: cardList,
    );
  }
}
