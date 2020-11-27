import 'package:flutter/material.dart';

// 1. Layout su 1 o 2 colonne attraverso LayoutBuilder / OrientationBuilder
// 2. Avatar che hanno un AspectRatio di 1 / 1
// 3. Azioni rapide visualizzare solamente su schermi grandi

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactModel selectedContact;

  @override
  Widget build(BuildContext context) {
    print("width: ${MediaQuery.of(context).size.width}");
    print("height: ${MediaQuery.of(context).size.height}");
    print("orientation: ${MediaQuery.of(context).orientation}");

    return ResponsiveBuilder(
      mobileChild: selectedContact != null ? chatDetail(hasBackArrow: true) : messageList(),
      tabletChild: Row(children: [
        Expanded(flex: 1, child: messageList()),
        Expanded(flex: 2, child: selectedContact == null ? Scaffold() : chatDetail(hasBackArrow: false)),
      ]),
      deskopChild: Row(children: [
        Expanded(flex: 1, child: messageList()),
        Expanded(flex: 2, child: selectedContact == null ? Scaffold() : chatDetail(hasBackArrow: false)),
      ]),
    );
  }

  Widget messageList() => Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text("Messaggi", style: TextStyle(fontSize: 15)),
        ]),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) => contact(contacts[index]),
      ));

  Widget chatDetail({bool hasBackArrow = false}) => Scaffold(
        appBar: AppBar(
          leading: hasBackArrow
              ? IconButton(
                  onPressed: () => setState(() => selectedContact = null),
                  icon: Icon(Icons.arrow_back),
                )
              : null,
          title: Row(children: [
            CircleAvatar(radius: 15, backgroundImage: NetworkImage(selectedContact.avatarUrl)),
            SizedBox(width: 15),
            Text(selectedContact.name, style: TextStyle(fontSize: 15)),
          ]),
          actions: MediaQuery.of(context).size.width < 400
              ? []
              : [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.video_call),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                  ),
                ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: selectedContact.messages.length,
            itemBuilder: (context, index) => message(selectedContact, selectedContact.messages[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        ),
      );

  Widget contact(ContactModel contact) => ListTile(
        onTap: () => setState(() => selectedContact = contact),
        leading: AspectRatio(aspectRatio: 1 / 1, child: CircleAvatar(backgroundImage: NetworkImage(contact.avatarUrl))),
        title: Text(contact.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(contact.messages[0]),
      );

  Widget message(ContactModel contact, String message) => Row(children: [
        CircleAvatar(radius: 15, backgroundImage: NetworkImage(contact.avatarUrl)),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(message),
          ),
        ),
      ]);
}

class ResponsiveBuilder extends StatelessWidget {
  ResponsiveBuilder({
    @required this.mobileChild,
    @required this.tabletChild,
    @required this.deskopChild,
  });

  final Widget mobileChild;
  final Widget tabletChild;
  final Widget deskopChild;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 400)
      return mobileChild;
    else if (width >= 400 && width < 1000)
      return tabletChild;
    else
      return deskopChild;
  }
}

class ContactModel {
  ContactModel({
    @required this.name,
    @required this.avatarUrl,
    @required this.messages,
  });

  final String name;
  final String avatarUrl;
  final List<String> messages;
}

final contacts = [
  ContactModel(
      name: "Gabriel Gatu",
      avatarUrl:
          "https://avatars1.githubusercontent.com/u/10064564?s=460&u=17f2f1ca994e3ab8834b096fd0c801b027cddf77&v=4",
      messages: [
        "Hey hey",
        "Rispondimi!",
        "-.-",
      ]),
  ContactModel(
      name: "Mario Rossi",
      avatarUrl: "https://pbs.twimg.com/profile_images/1238939034375852033/WVD5HR5G.jpg",
      messages: [
        "Odio mia madre per avermi dato questo nome!",
      ])
];
