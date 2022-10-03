import 'package:coinbase_clone/model/coin.dart';
import 'package:coinbase_clone/pages/coin_page.dart';
import 'package:coinbase_clone/services/coin_repository.dart';
import 'package:coinbase_clone/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/coin_price_bloc.dart';

class CoinDisplay extends StatefulWidget {
  const CoinDisplay({Key? key}) : super(key: key);

  @override
  State<CoinDisplay> createState() => _CoinDisplayState();
}

class _CoinDisplayState extends State<CoinDisplay> {
  late Future<List<Coin>> _getCoins;

  @override
  void initState() {
    _getCoins = CoinRepository.getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>>(
        future: _getCoins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            final coins = snapshot.data ?? [];
            return Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 40),
              child: Column(
                children: coins
                    .map((coin) => GestureDetector(
                        onTap: () {
                          // Navigate to the coin page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                      create: (context) => CoinPriceBloc()
                                        ..add(Start(coin.price)),
                                      child: CoinPage(coin: coin))));
                        },
                        child: CoinCard(coin: coin)))
                    .toList(),
              ),
            );
          }
          return const Center(child: Text("Loading"));
        });
  }
}
