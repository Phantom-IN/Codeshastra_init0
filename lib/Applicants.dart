import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Applicants extends StatefulWidget {
  const Applicants({super.key});

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  final CardSwiperController controller = CardSwiperController();

  DateTime currentDate = DateTime.now();

  List<Widget> buildDateCards() {
    List<Widget> dateCards = [];

    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    for (var i = 1; i <= daysInMonth; i++) {
      final date = DateTime(now.year, now.month, i);
      final dayName = DateFormat.E().format(date); // Weekday name
      final dayOfMonth = DateFormat.d().format(date); // Day of month

      bool isCurrentDate = date.day == currentDate.day && date.month == currentDate.month && date.year == currentDate.year;

      Widget card = Card(
        color: isCurrentDate ? Color(0xFF86b8fe) : Colors.white, // Highlighting the current date in blue
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(dayOfMonth, style: TextStyle(color: Color(0xFF505255),fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 7,),
                  Text(
                    dayName,
                    style: TextStyle(color: Color(0xFF505255)),
                  ),
                ],
              )
            ],
          ),
        ),
      );
      dateCards.add(card);
    }

    return dateCards;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> students = [
      {'sapId': '60009220079', 'name': 'Aryan Surve'},
      {'sapId': '60009210117', 'name': 'Tanisha Harde'},
      {'sapId': '60009210114', 'name': 'Abhishek Sinha'},
    ];

    List<Widget> cards = [];



    for (var student in students) {
      Widget card = Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Changes the position of the shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:"
                        ,style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20
                      ),),
                      Text("Aryan Surve",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("aryan2509surve@gmail.com",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Education:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("Diploma",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Age:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("20",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Linkedin:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("sfsfsfsfsfsfsfsf",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Github:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("wegxdyhdhdhdhdhdh",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Interest:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("Python, C++, C",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone:",style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),),
                      Text("9769215236",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 70.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 26),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.swipe(CardSwiperDirection.left);
                      _sendEmail('aryan2509surve@gmail.com', 'Result of application', 'Sorry you are not been able to cut through.');
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.close),
                        SizedBox(width: 8), // Add spacing between icon and text
                        Text("Reject"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16), // Add spacing between buttons
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.swipe(CardSwiperDirection.left);
                      _sendEmail('aryan2509surve@gmail.com', 'Result of application', 'You are selected');
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check),
                        SizedBox(width: 8), // Add spacing between icon and text
                        Text("Accept"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 26),
              ],
            ),
          ],
        ),
      );
      cards.add(card);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: const Text(
                "Review Applicants",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) =>
                cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint('The card $currentIndex was undone from the ${direction.name}');
    return true;
  }

  void _sendEmail(String emailid, String subject, String body) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [emailid],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }


}
