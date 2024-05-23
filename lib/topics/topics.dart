
import 'package:flutter/material.dart';
import 'package:quiz/services/firestore.dart';
import 'package:quiz/shared/bottom_nav.dart';
import 'package:quiz/shared/error.dart';
import 'package:quiz/shared/loading.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingScreen();
        }else if(snapshot.hasError){
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        }else if(snapshot.hasData){
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => Text(topic.title)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        }else{
          return const Text('No topics found in Firestore. Check database');
        }
      }
    );
  }
}