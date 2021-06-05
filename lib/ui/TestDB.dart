import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseCheck extends StatefulWidget {
  const DatabaseCheck({Key key}) : super(key: key);

  @override
  _DatabaseCheckState createState() => _DatabaseCheckState();
}

class _DatabaseCheckState extends State<DatabaseCheck> {
  var userStream;
  var userId="e3AZjSTcDWj9oHotw2nY";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream=FirebaseFirestore.instance.collection('names').doc(userId).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: userStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.hasData)
            {
              Map<String, dynamic> documentFields=snapshot.data.data();
              //userHistoryList=documentFields['name1'];
              return Container(
                child: Center(child: Text("${documentFields['name1']}")),
              );
            }
          else
            return Container(child: CircularProgressIndicator());
        }
      ),

    );
  }
}
