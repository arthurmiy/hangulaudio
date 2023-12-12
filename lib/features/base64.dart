import 'dart:convert';
import 'package:archive/archive.dart';

String encrypt(String input) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64Url);
  return stringToBase64.encode(input);
}

String decrypt(String input) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64Url);
  return stringToBase64.decode(input);

}

String encrypt2(String input) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64Url);
  var stringBytes = utf8.encode(input);
  var gzipBytes = GZipEncoder().encode(stringBytes);
  return stringToBase64.encode(base64.encode(gzipBytes!));
}

String decrypt2(String input) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64Url);
  var decompressedString = base64.decode(stringToBase64.decode(input));
  var gzipBytesDec = GZipDecoder().decodeBytes(decompressedString);
  return utf8.decode(gzipBytesDec);
}