import 'dart:convert';
import 'dart:typed_data';

const String KEY = "3e570pkt567wvg3r3e570pkt567wvg3r";

Uint8List base64Decode(String paramString) {
  return base64.decode(paramString);
}

String base64Encode(Uint8List paramArrayOfbyte) {
  String str2 = base64.encode(paramArrayOfbyte);
  String str1 = str2;
  if (str2 != null)
    str1 = str2.replaceAll("[\n\r]", "");
  return str1;
}

String decode(String paramString) {
  return utf8.decode(xorWithKey(base64Decode(paramString), utf8.encode(KEY)));
}

String encode(String paramString) {
  return base64Encode(xorWithKey(utf8.encode(paramString),
      utf8.encode(KEY)));
}

Uint8List xorWithKey(Uint8List paramArrayOfbyte1, Uint8List paramArrayOfbyte2) {
  Uint8List arrayOfByte = Uint8List(paramArrayOfbyte1.length);
  for (int i = 0; i < paramArrayOfbyte1.length; i++)
    arrayOfByte[i] = (paramArrayOfbyte1[i] ^ paramArrayOfbyte2[i % paramArrayOfbyte2.length]);

  return arrayOfByte;
}