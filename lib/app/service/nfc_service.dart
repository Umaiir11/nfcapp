import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'logger.dart';

class NfcService {
  static final NfcService _instance = NfcService._internal();
  factory NfcService() => _instance;
  NfcService._internal();

  Future<bool> isNfcAvailable() async {
    try {
      final availability = await FlutterNfcKit.nfcAvailability;
      final isAvailable = availability == NFCAvailability.available;
      if (!isAvailable) {
        Logger.error('NFC not available on this device');
      }
      return isAvailable;
    } catch (e) {
      Logger.error('Error checking NFC availability: $e');
      return false;
    }
  }

  Future<void> _endSession() async {
    try {
      await FlutterNfcKit.finish();
    } catch (e) {
      Logger.error('Error stopping NFC session: $e');
    }
  }

  Future<NFCTag?> _pollTag() async {
    try {
      return await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 10),
        androidPlatformSound: true,
      );
    } catch (e) {
      Logger.error('Error polling NFC tag: $e');
      return null;
    }
  }

  Future<String?> readNfcCard() async {
    if (!await isNfcAvailable()) {
      return null;
    }
    final tag = await _pollTag();
    if (tag == null) {
      await _endSession();
      return null;
    }
    try {
      Logger.info('NFC Tag Type: ${tag.type}');
      Logger.info('NFC Tag ID: ${tag.id}');
      String? dataString;
      if (tag.ndefAvailable == true) {
        final records = await FlutterNfcKit.readNDEFRecords(cached: false);
        for (var record in records) {
          if (record is ndef.TextRecord) {
            dataString = record.text;
            Logger.info('Read NDEF Text: $dataString');
          }
        }
      }
      return dataString ?? tag.id;
    } catch (e) {
      Logger.error('Error reading NFC card: $e');
      return null;
    } finally {
      await _endSession();
    }
  }

  Future<bool> writeToNfcCard(String data) async {
    if (!await isNfcAvailable()) {
      return false;
    }
    final tag = await _pollTag();
    if (tag == null) {
      await _endSession();
      return false;
    }
    try {
      if (tag.ndefAvailable == true && tag.ndefWritable == true) {
        final record = ndef.TextRecord(
          encoding: ndef.TextEncoding.UTF8,
          language: 'en',
          text: data,
        );
        await FlutterNfcKit.writeNDEFRecords([record]);
        Logger.info('Successfully written to NFC: $data');
        return true;
      } else {
        Logger.error('NDEF not available or tag not writable');
        return false;
      }
    } catch (e) {
      Logger.error('Error writing to NFC card: $e');
      return false;
    } finally {
      await _endSession();
    }
  }
}