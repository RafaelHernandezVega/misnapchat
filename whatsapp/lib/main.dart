import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(WhatsApp());

const String name = "Contacto";
final bd = Firestore.instance;
int id = 0;

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: new Estado(),debugShowCheckedModeBanner: false,));

  }
}



class Estado extends StatefulWidget{
  @override
  State createState() => new ChatScreenState();
}



class ChatScreenState extends State<Estado> {

  final List<ChatMessage> messages = <ChatMessage>[];
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var a = obtener();
    do {
      var a = obtener();
      if (a != null){
        messages.add(ChatMessage(text: a));
      }
    } while (a != null);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(7, 94, 84, 50),

        leading: IconButton(
            icon: Icon(Icons.account_circle, color: Colors.blue, size: 40,)),

        title: Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              alignment: Alignment(-1, 0),
              child: Text('Contacto', style: TextStyle(color: Colors.white, fontSize: 20,),),
            ),
            Container(
              alignment: Alignment(-1, 0),
              child:  Text('últ. vez hoy a la 1:42 p.m.', style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.videocam, color: Colors.white,),),
          IconButton(icon: Icon(Icons.call, color: Colors.white,),),
          IconButton(icon: Icon(Icons.more_vert, color: Colors.white,),)
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(20.0),
              reverse: true,
              itemBuilder: (_, int index) => messages[index],
              itemCount: messages.length,
            ),
          ),
          Divider(height: 5.0), //new
          Container( //new
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor),
            child: buildTextComposer(), //modified
          ),
        ],
      ),
    );
  }

  Widget buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[ Flexible(
            child: TextField(
              controller: textController,
              onSubmitted: handleSubmitted,
              decoration: InputDecoration.collapsed(
                  hintText: "Escribe un mensaje"),
              cursorColor: Color.fromRGBO(7, 94, 84, 50),
            ),
          ),
            Container( //new
              margin: EdgeInsets.symmetric(horizontal: 4.0), //new
              child: IconButton( //new
                  icon: Icon(Icons.send),
                  color: Color.fromRGBO(7, 94, 84, 50),//new
                  onPressed: () {
                    obtener();
                    insertar(textController.text);
                    handleSubmitted(textController.text);
                  },
              ), //new
            ),
          ],
        ),
      ),
    );
  }


  void handleSubmitted(String text) {
    textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      messages.insert(0, message);
    });
  }

  String obtener() {
    var mensaje;
    var documento = Firestore.instance.collection("WhatsAppContacto").document('$id');
    documento.get().then( (document) {
      mensaje = document["Mensaje"];
    });
    return mensaje;
//    bd.collection("WhasAppContacto").getDocuments()
//        .then((QuerySnapshot snapshot) {
//          snapshot.documents.forEach((f) => print("${f.data}"));
//    });
  }

}






class ChatMessage extends StatelessWidget {

  ChatMessage({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: Icon(Icons.account_circle,
              color: Colors.blue,
              size: 40,)
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(10, 140, 80, 100),
              borderRadius: BorderRadius.circular(17.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5.0,right: 20, left: 18),
                  child: Text( name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only( right: 20, left: 18, bottom: 5.0),
                  child: Text(text,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



void insertar(String mensaje) async {
  await bd.collection("WhatsAppContacto").document('$id').setData({'Mensaje': mensaje});
  id++;
}

String obtener() {
  var mensaje;
  var documento = Firestore.instance.collection("WhatsAppContacto").document('$id');
  documento.get().then( (document) {
    mensaje = document["Mensaje"];
  });
  return mensaje;
//    bd.collection("WhasAppContacto").getDocuments()
//        .then((QuerySnapshot snapshot) {
//          snapshot.documents.forEach((f) => print("${f.data}"));
//    });
}

void actualizar(String mensaje) async{
  await bd.collection("WhatsAppContacto").document('-LuO4kLpLue4t_vcxOEK').updateData({'mensaje': mensaje});
}


