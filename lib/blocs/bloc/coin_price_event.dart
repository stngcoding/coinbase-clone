part of 'coin_price_bloc.dart';

abstract class CoinPriceEvent extends Equatable {
  const CoinPriceEvent();

  @override
  List<Object> get props => [];
}

class Start extends CoinPriceEvent {
  final double coinPrice;

  Start(this.coinPrice);
}

class UpdateCoinPrice extends CoinPriceEvent {
  final double coinPrice;

  UpdateCoinPrice(this.coinPrice);
}
