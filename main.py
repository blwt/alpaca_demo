#!/usr/bin/env python3

from alpaca.data.live import CryptoDataStream
import os

class Crypto(object):
    def __init__(self, stream, symbol):
        self.symbol = symbol
        self.stream = stream
        self.high = 0

    async def barCallback(self, bar):
        for property_name, value in bar:
            print(f"\"{property_name}\": {value}")
            if property_name == "high":
                if value > self.high:
                    self.high = value
                    print(f"High updated to {self.high} for {self.symbol}")

    def subscribeBars(self):
        self.stream.subscribe_bars(self.barCallback, self.symbol)

if __name__ == '__main__':
    key_id = os.getenv("APCA_API_KEY_ID")
    secret_key = os.getenv("APCA_API_SECRET_KEY")

    crypto_stream = CryptoDataStream(key_id, secret_key)

    btc = Crypto(crypto_stream, "BTC/USD")
    eth = Crypto(crypto_stream, "ETH/USD")

    btc.subscribeBars()
    eth.subscribeBars()

    crypto_stream.run()
