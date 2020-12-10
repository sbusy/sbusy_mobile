import 'dart:io';
import 'package:flutter/material.dart';
import '../../backend/models/chat_message.dart';
import '../../backend/models/send_menu_items.dart';
import '../../backend/models/language.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

const languages = const [
  const Language('Pусский', 'ru_RU'),
];

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _controller = TextEditingController();

  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  bool canSend = false;

  Language selectedLang = Language('Pусский', 'ru_RU');

  String transcription = '';

  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Привет", type: MessageType.Receiver),
    ChatMessage(message: "Чем я могу помочь?", type: MessageType.Receiver)
  ];

  List<SendMenuItems> menuItems = [
    SendMenuItems(text: "Фото & Видео", icons: Icons.image, color: Colors.amber),
    SendMenuItems(text: "Документ", icons: Icons.insert_drive_file, color: Colors.blue),
    SendMenuItems(text: "Аудио", icons: Icons.music_note, color: Colors.orange),
    SendMenuItems(text: "Геопозиция", icons: Icons.location_on, color: Colors.green),
    SendMenuItems(text: "Контакт", icons: Icons.person, color: Colors.purple),
  ];

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void showModal(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
              height: 410,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16,),
                    Center(
                      child: Container(
                        height: 4,
                        width: 50,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[index].color.shade50,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(menuItems[index].icons,size: 20,color: menuItems[index].color.shade400,),
                            ),
                            title: Text(menuItems[index].text),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      ListView.builder(
          itemCount: chatMessage.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => chatBubble(
            chatMessage[index],
          )
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(left: 16,bottom: 10),
          height: 80,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  showModal();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.add,color: Colors.white,size: 21,),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Напишите сообщение...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none
                  ),
                  onChanged: (value) {
                    if (value != "")
                      setState(() => canSend = true);
                    else setState(() => canSend = false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: EdgeInsets.only(right: 30,bottom: 50),
          child: FloatingActionButton(
            onPressed: (){},
            child: !canSend
                ? GestureDetector(
              onTap: () async {
                if (Platform.isAndroid)
                  if (await Permission.microphone.status.isUndetermined)
                    Permission.microphone.request();
                activateSpeechRecognizer();
                if (_speechRecognitionAvailable)
                  if (!_isListening)
                    start();
                  else cancel();
              },
              child: Icon(Icons.keyboard_voice, color: Colors.white),
            )
                : GestureDetector(
              onTap: () {
                chatMessage.add(ChatMessage(message: _controller.text, type: MessageType.Sender));
                setState(() => _controller.text = "");
              },
              child: Icon(Icons.send, color: Colors.white),
            ),
            backgroundColor: Colors.pink,
            elevation: 0,
          ),
        ),
      )
    ],
  );


  Container chatBubble(ChatMessage chatMessage) => Container(
    padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
    child: Align(
      alignment: (chatMessage.type == MessageType.Receiver
          ? Alignment.topLeft
          : Alignment.topRight),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: (chatMessage.type  == MessageType.Receiver
              ? Colors.white
              : Colors.grey.shade200),
        ),
        padding: EdgeInsets.all(16),
        child: Text(chatMessage.message),
      ),
    ),
  );

  void start() => _speech
      .listen(locale: Language('Pусский', 'ru_RU').code)
      .then((result) => print('_MyAppState.start => result ${result}'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
            () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() => _controller.text = text);

  void onRecognitionComplete() => setState(() => _isListening = false);
}