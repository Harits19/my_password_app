class ShareService {
  // Future<void> export(ShareModel shareModel) async {
  //   final tempPath = await getTemporaryDirectory();
  //   final jsonFile = File('${tempPath.path}/daily_routine.txt');
  //   if (!(await jsonFile.exists())) {
  //     await jsonFile.create(recursive: true);
  //   }
  //   final dailyRoutineString = jsonEncode(shareModel.toJson());
  //   final encodedEncrypt = EncryptData.encode(dailyRoutineString);
  //   await jsonFile.writeAsString(encodedEncrypt);
  //   Share.shareXFiles([XFile(jsonFile.path)]);
  // }

  // Future<ShareModel?> import() async {
  //   final pickerResult = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['txt'],
  //   );
  //   if (pickerResult == null) return null;
  //   final pathFile = pickerResult.files.single.path;
  //   if (pathFile == null) return null;
  //   final jsonFile = File(pathFile);
  //   final dailyRoutineString = await jsonFile.readAsString();
  //   final decodeEncrypt = EncryptData.decode(dailyRoutineString);
  //   final dailyRoutineDecode = jsonDecode(decodeEncrypt);
  //   final dailyRoutine = ShareModel.fromJson(dailyRoutineDecode);
  //   return dailyRoutine;
  // }
}
