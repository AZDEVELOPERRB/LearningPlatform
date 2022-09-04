import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/ExaminateNow/examinate_now.dart';
import 'package:learningplatform_rb/providers/CustomerExamsProvider/customer_exams_provider.dart';

class CustomerExams extends StatefulWidget {
  CustomerExams({@required this.subjectId});

  final String subjectId;

  @override
  _CustomerExamsState createState() => _CustomerExamsState();
}

class _CustomerExamsState extends State<CustomerExams> {
  CustomerExamsProvider customerExamsProvider;

  @override
  void initState() {
    customerExamsProvider = CustomerExamsProvider(widget.subjectId);
    customerExamsProvider.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.blue.withOpacity(0.5),
          centerTitle: true,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(size.width, 55.0),
            ),
          )),
      body: Stack(
        children: [
          ListView(
            children: [
              ValueListenableBuilder<List<ExamModel>>(
                  valueListenable: customerExamsProvider.exams,
                  child: const SizedBox(),
                  builder:
                      (BuildContext context, List<ExamModel> exams, child) {
                    if (exams == null) return child;
                    if (exams.isEmpty)
                      return const Align(
                        child: RoyalEmptyData(),
                      );
                    return ListView.builder(
                      itemCount: exams.length,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, final int index) {
                        final ExamModel exam = exams[index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "Assets/images/gamebackground.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 9.0,
                                    spreadRadius: 3.0)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    exam.name,
                                    style: const TextStyle(
                                        color: Colors.brown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    " مادة " + exam.subject.name,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.center,
                                    textDirection:TextDirection.rtl,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RoyalRoundedButton(
                                          exam.done
                                              ? "رؤية الاسئلة"
                                              : 'بدأ الامتحان الآن',
                                          () {
                                            Navigator.push(
                                                context,
                                                RoyalNavigatorElasticInOut(
                                                    ExaminateNow(exam)));
                                          },
                                          circular: 25,
                                          buttoncolor: exam.done
                                              ? Colors.orange.shade300
                                              : Colors.green,
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (exam.done)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      decoration: BoxDecoration(
                                          color: exam.done
                                              ? Colors.green
                                              : Colors.black54,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        exam.done
                                            ? "لقد اديت هذا الامتحان"
                                            : "لم تقم باداء هذا الامتحان",
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
          ValueListenableBuilder<bool>(
              valueListenable: customerExamsProvider.loading,
              child: const SizedBox(),
              builder: (BuildContext context, bool load, child) {
                if (load == true) return const RoyalLoadingLinear();

                if (load == false &&
                    customerExamsProvider?.pagination?.next != null)
                  return Align(
                    alignment: const Alignment(-0.9, 0.95),
                    child: RoyalRoundedButton(
                      "تحميل المزيد",
                      () {
                        customerExamsProvider.initialize();
                      },
                      circular: 35,
                    ),
                  );
                return child;
              })
        ],
      ),
    );
  }
}
