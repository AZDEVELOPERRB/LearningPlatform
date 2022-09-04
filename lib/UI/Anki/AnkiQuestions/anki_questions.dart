import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/AnkiElement/anki_question.dart';
import 'package:learningplatform_rb/UI/VoicePlayer/royal_voice_player.dart';
import 'package:learningplatform_rb/providers/AnkiElementProvider/anki_element_provider.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';

class AnkiQuestions extends StatefulWidget {
  const AnkiQuestions(
      {@required this.provider, this.message = "لا توجد بطايق ", Key key})
      : super(key: key);
  final AnkiElementsProvider provider;
  final String message;

  @override
  _AnkiQuestionsState createState() => _AnkiQuestionsState();
}

class _AnkiQuestionsState extends State<AnkiQuestions> {
  final double circularDegree = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key:UniqueKey(),
      body: ValueListenableBuilder(
          valueListenable: widget.provider.notifier,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (BuildContext context, List<AnkiQuestion> value, _) {
            if (value == null) {
              return _;
            }
            if (value.isEmpty)
              return RoyalEmptyData(
                message: widget.message,
              );
            AnkiQuestion question = value.first;
            return Stack(
              children: [
                ListView(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    if (question.hours != null)
                      Center(child: Text(question.getTimeToShow())),
                    if (question.hasImages())
                      RoyalCacheImage(
                        question.images.first.url,
                        fit: BoxFit.fill,
                        width: size.width,
                      ),
                    if (question.voice != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Align(
                          child: RoyalVoicePlayer(
                            url: question.voice.url,
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    if (widget.provider.showAnswer)
                      ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Center(
                              child: Text(
                            'الاجابة هي : ',
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              question.answer.answer,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                          if (question.answer.hasImages())
                            RoyalCacheImage(
                              question.answer.images.first.url,
                              fit: BoxFit.fill,
                              width: size.width,
                            ),
                          if (question.answer.voice != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: Align(
                                child: RoyalVoicePlayer(
                                  url: question.answer.voice.url,
                                  backGroundColor: Colors.green.shade100,
                                  key: UniqueKey(),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: size.height / 6,
                          )
                        ],
                      ),
                    if (!widget.provider.showAnswer)
                      Align(
                          child: RoyalRoundedButton(
                        "اظهار الاجابة",
                        () {
                          setState(() {
                            widget.provider.showAnswer = true;
                          });
                        },
                        circular: 20,
                      ))
                  ],
                ),
                if (widget.provider.showAnswer)
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6.0),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.elliptical(size.width, 70)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.cyan.withOpacity(0.5),
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0)
                            ]),
                        child: FittedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '-  كيف كانت الاجابة ؟  -',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RoyalRoundedButton(
                                    "سهلة",
                                    () {
                                      readQuestion(
                                          AnkiQuestionType.easy, context);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          'سهلة',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${widget.provider.getNextCardTime(Constans.ankiSchedulingHours(hours: 12, oldHours: question.hours))}",
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        )
                                      ],
                                    ),
                                    buttoncolor: Colors.green,
                                    circular: circularDegree,
                                  ),
                                  RoyalRoundedButton(
                                    "متوسطة"
                                            "\n" +
                                        "",
                                    () {
                                      readQuestion(
                                          AnkiQuestionType.medium, context);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          'متوسطة',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${widget.provider.getNextCardTime(Constans.ankiSchedulingHours(hours:8, oldHours: question.hours))}",
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        )
                                      ],
                                    ),
                                    buttoncolor: Colors.blue,
                                    circular: circularDegree,
                                  ),
                                  RoyalRoundedButton(
                                    "صعبة"
                                            "\n" +
                                        "",
                                    () {
                                      readQuestion(
                                          AnkiQuestionType.hard, context);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          'صعبة',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${widget.provider.getNextCardTime(Constans.ankiSchedulingHours(hours:4, oldHours: question.hours))}",
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        )
                                      ],
                                    ),
                                    buttoncolor: Colors.orange,
                                    circular: circularDegree,
                                  ),
                                  RoyalRoundedButton(
                                    "تخطي"
                                            "\n" +
                                        "فيما بعد !",
                                    () {
                                      readQuestion(
                                          AnkiQuestionType.skip, context);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          'تخطي',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "بطاقة اخرى !",
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        )
                                      ],
                                    ),
                                    buttoncolor: Colors.red,
                                    circular: circularDegree,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
              ],
            );
          }),
    );
  }

  Widget eventButton(final String hint, final GestureTapCallback onTap,
          {final Color buttoncolor, final int hours, oldHours}) =>
      Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(circularDegree),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: buttoncolor,
                borderRadius: BorderRadius.circular(circularDegree)),
            child: Column(
              children: [
                Text(hint),
                Text(
                    "${widget.provider.getNextCardTime(Constans.ankiSchedulingHours(hours: hours, oldHours: oldHours))}")
              ],
            ),
          ),
        ),
      );

  readQuestion(AnkiQuestionType type, BuildContext context) async {
    widget.provider.readQuestion(type, context: context);
  }
}
