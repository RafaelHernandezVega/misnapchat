import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:camera/camera.dart';

void main() => runApp(Chat());

final bd = Firestore.instance;
int id = 0;

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Estado();
  }
}

class Estado extends StatefulWidget {
  @override
  State createState() => new ChatState();
}

class ChatState extends State<Estado> {
  final textController = TextEditingController();

  Widget buildItem(int index, DocumentSnapshot document) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 200.0,
        padding: EdgeInsets.fromLTRB(200.0, 0, 0.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(10, 10, 10, .1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        right: 12, left: 12, top: 7, bottom: 5.0),
                    child: Text(
                      document.data['Mensaje'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500));

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(7, 94, 84, 50),
              leading: IconButton(
                  icon: Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 40,
              ),
                onPressed: (){

              },
              ),
              title: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      'Contacto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      'últ. vez hoy a la 1:42 p.m.',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.videocam,
                    color: Colors.white,
                  ),
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: (){

                  },
                )
              ],
            ),
            body: Container(
              child: StreamBuilder(
                  stream: bd.collection("WhatsAppContacto").snapshots(),
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child: ListView.builder(
                            padding: EdgeInsets.all(20.0),
                            reverse: false,
                            itemBuilder: (context, index) => buildItem(
                                index, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                          ),
                        ),
                        Divider(height: 5.0),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor),
                            child: buildTextComposer()),
                      ],
                    );
                  }),
            )));
  }

  Widget buildTextComposer() {
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          //color: Color.fromRGBO(10, 10, 10, .1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.insert_emoticon),
              onPressed: (){
                EmojiPicker(
                  rows: 3,
                  columns: 7,
                  //recommendKeywords: ["racing", "horse"],
                  numRecommended: 10,
                  onEmojiSelected: (emoji, category) {
                    print(emoji);
                  },
                );
              }
            ),
            Flexible(
              child: TextField(
                controller: textController,
                onSubmitted: (String text) {
                  insertar(textController.text);
                  textController.clear();
                },
                decoration:
                    InputDecoration.collapsed(hintText: "Escribe un mensaje"),
                cursorColor: Color.fromRGBO(7, 94, 84, 50),
              ),
            ),
            IconButton(
                icon: Icon(Icons.attach_file)
            ),
            IconButton(
                icon: Icon(Icons.camera_alt),
              onPressed: (){

              },
            ),
            Container(
              //new
              margin: EdgeInsets.symmetric(horizontal: 4.0), //new
              child: IconButton(
                //new
                icon: Icon(Icons.send),
                color: Color.fromRGBO(7, 94, 84, 50), //new
                onPressed: () {
                  insertar(textController.text);
                  textController.clear();
                },
              ), //new
            ),
          ],
        ),

    );
  }
}

void insertar(String mensaje) async {
  await bd.collection("WhatsAppContacto").add({'id': id, 'Mensaje': mensaje});
  id++;
}
