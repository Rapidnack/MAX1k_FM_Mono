# MAX1k_FM_Mono

MAX1k_FM_Monoプロジェクトは、Intel MAX10 FPGAを使ったFMラジオのVerilogソースコードです。

![全体画像](http://rapidack.sakura.ne.jp/ttl/wp-content/uploads/2019/03/Overall-image.png)

- 開発環境: Quartus Prime Lite Edition 18.1
- FPGAボード: Arrow Development Tools MAX1000
- コントローラ: ESP32
- ADC: Analog Devices AD9283
- I2S DAC: PCM5102A

選局、音量はESP32のタッチセンサーを使います。
別プロジェクト[AvalonPacket](https://github.com/Rapidnack/AvalonPacket)のArduinoライブラリをArduino IDEにインポートし、
サンプルスケッチAvalonPacket_FM_Radioを書き込んでください。

![操作パネル](http://rapidack.sakura.ne.jp/ttl/wp-content/uploads/2019/03/FrontPanel.png)

# Authors

[Rapidnack](http://rapidnack.com/)

# References

[https://github.com/Rapidnack/AvalonPacket](https://github.com/Rapidnack/AvalonPacket)