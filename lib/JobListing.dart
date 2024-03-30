import 'package:flutter/material.dart';

class JobListing extends StatefulWidget {
  const JobListing({super.key});

  @override
  State<JobListing> createState() => _JobListingState();
}

class _JobListingState extends State<JobListing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "Job Listing"
          ),
        ),
      ),
    );
  }
}
