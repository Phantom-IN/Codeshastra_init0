import 'package:flutter/material.dart';

class JobListing extends StatefulWidget {
  const JobListing({Key? key}) : super(key: key);

  @override
  State<JobListing> createState() => _JobListingState();
}

class _JobListingState extends State<JobListing> {

  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2), // Adjust opacity here
                borderRadius: BorderRadius.circular(20.0), // Make border circular
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white70,
                      controller: _searchController,
                      onSubmitted: (value) {
                        setState(() {
                          isSearching = true;
                        });
                      },
                      onChanged: (value1){
                        if(value1.isEmpty){
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Find Location",
                        hintStyle: TextStyle(color: Colors.white70, fontFamily: "crete"),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: "crete"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
