import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:ozai_chatboot/ChatService.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SportPlannerBot extends StatefulWidget {
  const SportPlannerBot({super.key});

  @override
  State<SportPlannerBot> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<SportPlannerBot> {
  List<Map<String, Object>> chatHistory = [
    {
      "content":
          "You are a certified fitness coach and sport planner. Your job is to provide expert advice, structured answers, and practical strategies in the field of physical training and fitness. You assist users with workout planning, weight loss, muscle gain, endurance improvement, recovery, stretching, sport-specific training, and healthy habits.\n\n"
          "Always ask clarifying questions if needed, such as the user's goal, training level, body type, available equipment, time availability, or nutrition habits.\n\n"
          "Structure your answers clearly and concisely. Offer direct, actionable plans or recommendations that are easy to follow and adapted to the user’s context.\n\n"
          "When users ask:\n"
          "- If they request help with building muscle → suggest a clear routine, rep ranges, rest time, and weekly structure. Ask if they have equipment.\n"
          "- If they ask how to lose fat → explain the role of calorie deficit, cardio vs strength, and nutrition habits.\n"
          "- If they want to improve performance → recommend specific exercises, warmups, and recovery strategies adapted to their sport.\n"
          "- If they mention body pain or injury → advise rest or basic rehab, and encourage consulting a professional if needed.\n"
          "- If they want a routine → provide a simple weekly training plan with sets and reps.\n\n"
          "Stay focused on sport-related topics. If the question is outside your domain, politely redirect the user to ask something about training, fitness, or sport health.\n\n"
          "Respond in a motivating, friendly, and confident tone. Make the user feel supported and inspired to stay consistent and improve their health."
          "\nKeep all responses under 100 words..",
      "role": "system",
    },
  ];
  ChatService chatservice = ChatService();
  askDeepSeek() async {
    var inputText = textEditingController.text;
    chatHistory.add({"role": "user", "content": inputText});
    messages.insert(
      0,
      ChatMessage(user: user, createdAt: DateTime.now(), text: inputText),
    );
    setState(() {
      messages;
      isLoading = true;
    });
    textEditingController.clear();
    results = await chatservice.askDeepSeek(chatHistory);
    chatHistory.add({"role": "assistant", "content": results});
    messages.insert(
      0,
      ChatMessage(user: userDS, createdAt: DateTime.now(), text: results),
    );
    setState(() {
      messages;
      isLoading = false;
    });
    if (isTTSenabled) {
      flutterTts.speak(results);
    }
    // print(response.body);
  }

  TextEditingController textEditingController = TextEditingController();
  var results = "results too be shown here...";
  ChatUser user = ChatUser(id: '1', firstName: 'NAIDJA', lastName: 'Zakaria');
  ChatUser userDS = ChatUser(id: '2', firstName: 'Deep', lastName: 'Seek');
  List<ChatMessage> messages = <ChatMessage>[];
  FlutterTts flutterTts = FlutterTts();
  bool isTTSenabled = true;

  exploreTTS() async {
    List<dynamic> languages = await flutterTts.getLanguages;
    languages.forEach((language) {
      print("languages: " + language);
    });
    List<dynamic> voices = await flutterTts.getVoices;
    voices.forEach((voice) {
      print("voices: " + voice.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exploreTTS();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Image.asset("assets/sport.png"),
        title: Text("AI Sport Planner ", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (isTTSenabled) {
                isTTSenabled = false;
                flutterTts.stop();
              } else {
                isTTSenabled = true;
              }
              setState(() {
                isTTSenabled;
              });
            },
            icon: Icon(
              isTTSenabled
                  ? Icons.record_voice_over_sharp
                  : Icons.voice_over_off,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              messages.isNotEmpty
                  ? Expanded(
                      child: DashChat(
                        currentUser: user,
                        onSend: (e) {},
                        messages: messages,
                        readOnly: true,
                        messageOptions: MessageOptions(
                          currentUserContainerColor: Colors.indigo,
                          messageTextBuilder:
                              (message, previousMessage, nextMessage) {
                                // You can detect if this message is from the bot or user
                                bool isUserMessage = message.user.id == user.id;

                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isUserMessage
                                        ? Colors.indigo
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: MarkdownBody(
                                    // <- render the message.text as Markdown
                                    data: message.text ?? "",
                                    styleSheet: MarkdownStyleSheet(
                                      p: TextStyle(
                                        fontSize: 16,
                                        color: isUserMessage
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      h1: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: isUserMessage
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      h2: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isUserMessage
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      h3: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isUserMessage
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      listBullet: TextStyle(
                                        fontSize: 16,
                                        color: isUserMessage
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/sport.png",
                            width: 250,
                            height: 250,
                          ),
                          Text(
                            "Hello Ro!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "What is the purpose of your visit today",
                            style: TextStyle(fontSize: 13),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  textEditingController.text =
                                      "How can I gain muscle in a healthy and effective way?";
                                  askDeepSeek();
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      top: 5,
                                      right: 10,
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      "Gain Muscle",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  textEditingController.text =
                                      "Why is stretching important, and when should I do it?";
                                  askDeepSeek();
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      top: 5,
                                      right: 10,
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      "Stretching",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Write here...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (textEditingController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Write your question !"),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }
                          askDeepSeek();
                        },
                        icon: Icon(Icons.send_sharp, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isLoading
              ? Center(
                  child: Lottie.asset(
                    "assets/chatanime1.json",
                    height: 100,
                    width: 100,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
