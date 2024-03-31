import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0.0, -0.40),
                color: Colors.white,
                height: 100.0,
                child: const Text(
                  "Get coaching",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 5.0, 5.0),
                          child: const Text(
                            "YOU HAVE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 5.0, 15.0),
                          child: const Text(
                            "206",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 100.0,
                          top: 58.0,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[100]?.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "Buy more",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "MY COACHES",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "VIEW PAST SESSIONS",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            primary: false,
            children: const <Widget>[
              _Card(
                name: "Jake Peralta",
                status: "Available",
                cardIndex: 1,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Raymond Holt",
                status: "Away",
                cardIndex: 2,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Rosa Diaz",
                status: "Away",
                cardIndex: 3,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Charles",
                status: "Available for Jake",
                cardIndex: 4,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Amy Santiago",
                status: "Away",
                cardIndex: 5,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Gina Leneti",
                status: "You bet",
                cardIndex: 6,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Hitchcock",
                status: "Always Available",
                cardIndex: 7,
                image: "assets/img1.jpg",
              ),
              _Card(
                name: "Terry",
                status: "Away",
                cardIndex: 8,
                image: "assets/img1.jpg",
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          // PS: If you are removing the credits section then kindly give a star on github at https://github.com/AkashRajpurohit/Flutter-Hire-App-UI
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}

class _Card extends StatefulWidget {
  final String name;
  final String status;
  final String image;
  final int cardIndex;

  const _Card({
    required this.name,
    required this.status,
    required this.image,
    required this.cardIndex,
  });

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      margin: widget.cardIndex.isEven
          ? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
          : const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Stack(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 42.0),
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: widget.status == "Away" ? Colors.amber : Colors.green,
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.status,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.grey,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 11.0),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Container(
                width: 175.0,
                decoration: BoxDecoration(
                  color: isChecked ? Colors.green : Colors.grey[400],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Request",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}