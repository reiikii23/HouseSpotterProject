import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    const List<String> skills = [
      'Frontend Development',
      'Mobile Development',
      'UI/UX Design',
      'Backend Development',
      'Full Stack Development'
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Column(
          spacing: 16,
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Text(
                'Johnny Verzola',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  'I am a passionate mobile developer. I love to create mobile applications that benefit a wide-range of users.',
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Skills',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                //textAlign: TextAlign.left,
              ),
            ),
            ...skills.map((skill) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        skill,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
