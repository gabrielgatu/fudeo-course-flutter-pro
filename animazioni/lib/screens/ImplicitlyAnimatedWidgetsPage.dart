import 'package:flutter/material.dart';

class ImplicitlyAnimatedWidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ImplicitlyAnimatedWidget"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: ExpandableCard(
              collapsedChild: Text("Collapsed"),
              expandedChild: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ex mauris, lacinia eu pharetra a, vestibulum eu metus. Quisque at molestie arcu. Fusce feugiat nisi dui, id ornare nisi feugiat vel. Pellentesque pretium diam vitae tempor pretium. Donec dictum justo sit amet massa dictum, scelerisque mattis massa accumsan."),
            ),
          )),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  ExpandableCard({
    @required this.expandedChild,
    @required this.collapsedChild,
  });

  final Widget expandedChild;
  final Widget collapsedChild;

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => expanded = !expanded),
      child: Card(
        child: Column(children: [
          AspectRatio(
              aspectRatio: 3 / 2,
              child: AnimatedCrossFade(
                firstChild: Image.network(
                  "https://images.unsplash.com/photo-1601758004584-903c2a9a1abc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80",
                  fit: BoxFit.cover,
                ),
                secondChild: Image.network(
                  "https://images.unsplash.com/photo-1568979928406-bd5248b2c992?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80",
                  fit: BoxFit.cover,
                ),
                duration: Duration(milliseconds: 300),
                crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              )),
          AnimatedContainer(
            height: expanded ? 200 : 60,
            duration: Duration(milliseconds: 300),
            curve: Curves.decelerate,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: expanded ? widget.expandedChild : widget.collapsedChild,
              ),
            ),
          ),
          AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(child: child, scale: animation),
              child: Text(expanded ? "Pagina: 2" : "Pagina 1",
                  key: ValueKey(expanded), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
}
