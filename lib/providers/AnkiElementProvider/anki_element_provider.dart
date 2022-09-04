import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/AnkiElement/anki_question.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/database/AnkiScheduleDataBase/anki_sechdule_cache_system.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/RoyalBoardProvider/royal_board_provider.dart';
import 'package:learningplatform_rb/Repos/AnkiRepo/anki_repo.dart';

class AnkiChaptersProvider extends RoyalBoardProvider {
  AnkiChaptersProvider({@required this.id}) : super(Api.ankiChapters + id);
  final String id;
  final ValueNotifier<List<ChapterModel>> notifier = ValueNotifier(null);

  init() {
    cache();
    internet();
  }

  cache() {
    build(getFromDataBase());
  }

  internet() async {
    build(await getFromInternet());
  }

  build(final dynamic data) {
    if (data is List) {
      notifier.value = [];
      try {
        for (final dynamic json in data) {
          notifier.value = List.from(notifier.value)
            ..add(ChapterModel.fromJson(json));
        }
      } catch (e) {
        Constans.toast("يرجى المحاولة لاحقاً", false);
      }
    }
  }

  buy(final BuildContext context, final String id) async {
    final AnkiRepo ankiRepo = AnkiRepo(id);
    royalLoading.loading(context);
    final RS rs = await ankiRepo.post({});
    royalLoading.cancel();
    if (rs.check()) {
      try {
        ChapterModel chapterModel = ChapterModel.fromJson(rs.data);
        updateNotifier(chapterModel);
        updateLocalInformation(rs.data);
      } catch (e) {}
    }
  }

  updateNotifier(final ChapterModel chapterModel) {
    if (notifier.value != null && notifier.value.isNotEmpty) {
      for (int i = 0; i < notifier.value.length; i++) {
        final ChapterModel old = notifier.value[i];
        if (old.id == chapterModel.id) {
          notifier.value[i] = chapterModel;
          notifier.value = List.from(notifier.value);
        }
      }
    }
  }
}

/// Anki Element
class AnkiElementsProvider extends RoyalBoardProvider {
  AnkiElementsProvider(this.subject,this.chapter,{@required this.id})
      : scheduleCacheSystem = AnkiScheduleCacheSystem(id,subject,chapter),
        super(Api.ankiElements + id);
  final String id;
  final SubjectModel subject;
  final ChapterModel chapter;
  final ValueNotifier<List<AnkiQuestion>> notifier = ValueNotifier(null);
  final AnkiScheduleCacheSystem scheduleCacheSystem;

  String base;
  String dataType = "normal";
  int readCount = 0;
  bool showAnswer = false;

  init({final bool fromInternet = true}) {
    cache();
    if (fromInternet) internet();
  }

  cache() {
    build(getFromDataBase());
  }

  internet() async {
    build(await getFromInternet());
  }

  /// On Data Fetched from Internet

  formNotifier(final dynamic elements) {
    if (elements is Map) {
      notifier.value = [];
      elements.forEach((key, json) {
        notifier.value = List.from(notifier.value)
          ..add(AnkiQuestion.fromJson(json));
      });
    }
  }

  showLearningMode() {
    dataType = scheduleCacheSystem.learning;
    init();
  }

  addedToLearningMode(final String id) {
    scheduleCacheSystem.changeOver(id);
    List<AnkiQuestion> list = notifier.value;
    for (int i = 0; i < list.length; i++) {
      final AnkiQuestion ankiQuestion = list[i];
      if (ankiQuestion.id == id) {
        list.removeAt(i);
        notifier.value = List.from(list);
      }
    }
  }

  build(final dynamic data, {final bool internet = false}) async {
    if (base64 == null || data != base64) {
      if (data != null){
        base = data;
      }
      else{return;}
      try {
        final Map resource = decodeResponse(data);
        if (checkMap(resource)) {
          final dynamic cards = resource['data'];
           Map ankiSystem =(await scheduleCacheSystem.saveAnkiData(cards))[dataType]??{};
           dynamic timeCards;
          if(dataType==scheduleCacheSystem.time){
            timeCards={};
            ankiSystem.forEach((key,value){
              final AnkiQuestion question=AnkiQuestion.fromJson(value);
              if(question.hasScheduleWright()){
                timeCards[key]=value;
              }
            });
          }

          formNotifier(timeCards??ankiSystem);
        }
      } catch ( e) {
        return cacheErrors(e.toString());
      }
    }
  }




  /// getNextTime
 String  getNextCardTime(int period){
    final DateTime now=DateTime.now();
    final DateTime nextTime=now.add(Duration(hours:period));
    final Duration difference=nextTime.difference(now);
    int days=difference.inDays;
    int hours=difference.inHours;
    if(days > 360){
      return (days/30).toStringAsFixed(1)+" سنة ";
    }
    if(days>30){
      return (days/30).toStringAsFixed(1)+" شهر ";
    }
    if(hours>24){
      return (hours/24).toStringAsFixed(1)+" يوم ";
    }
    return hours.toString()+" ساعة ";
  }
  ///
  bool checkMap(Map resource) {
    if (resource.containsKey("token") && resource.containsKey("data")) {
      if (resource['token'] == BaseLocal.token()) {
        return true;
      }
    }
    return false;
  }

  Map decodeResponse(final dynamic data) {
    try {
      final Uint8List bytes = base64Decode(data);
      final String base64 = utf8.decode(bytes);
      final Map resource = json.decode(base64);
      return resource;
    } catch (e) {
      return null;
    }
  }


  readQuestion(AnkiQuestionType ankiQuestionType,
      {BuildContext context, Function exit}) {

    showAnswer=false;

     final Map keyMap = scheduleCacheSystem.bringKey();
     Map data = keyMap[dataType];
    final AnkiQuestion question = notifier.value.first;

    if (data is Map ) {
      if (data.containsKey(question.id)) {
        int hours;
        /// lets Handle event Type

        /// if easy
        if (ankiQuestionType == AnkiQuestionType.easy) {
          hours = 12;
        }

        /// if medium
        if (ankiQuestionType == AnkiQuestionType.medium) {
          hours = 8;
        }

        /// if hard
        if (ankiQuestionType == AnkiQuestionType.hard) {
          hours = 4;
        }
        /// if skip
        if (ankiQuestionType == AnkiQuestionType.skip) {
          hours = null;
          if(notifier.value.length==1){
            Constans.toast("هذه البطاقة الوحيدة المتبقية ",false);
          }
          else{
            final AnkiQuestion q=notifier.value.first;
            notifier.value.removeAt(0);
            notifier.value.add(q);
            notifier.value=List.from(notifier.value);
          }
        }
        if(hours!=null){
          scheduleCacheSystem.changeOver(question.id,from:dataType,to:scheduleCacheSystem.time,hours:hours);
          cache();
          scheduleCacheSystem.notifyNearestCard();
        }
        // data.remove(key);

      }
    }
  }

  encodeThenBuild(final String data) {
    final String baseEncoded = base64.encode(utf8.encode(data));
    build(baseEncoded);
  }

  cacheErrors(final String error) {
    if (Constans.royalDebug) print(error);
    Constans.toast("يرجى المحاولة لاحقاً",true);
  }

  wantToExit(BuildContext context) {
    RoyalDialog.showMessage(
      context,
      message: "لقد قرأت عدد جميل من البطايق تستطيع الاكمال احسنت ؟",
      backMessage: "لقد فهمت ",
      agreeMessage: "خروج",
    );
  }

  updateNotifier(final ChapterModel chapterModel) {}
}

enum AnkiQuestionType { easy, hard, medium, skip }
