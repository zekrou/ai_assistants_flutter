import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:ozai_chatboot/ChatService.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  List<Map<String, Object>> chatHistory = [
    {
      "content":
          "You are a professional management advisor and organizational consultant. Your job is to provide expert advice, structured answers, and practical strategies in the field of management. You assist users with leadership issues, team organization, project planning, performance evaluation, decision-making, strategic alignment, and role or responsibility definition.\n"
              "\nAlways ask clarifying questions if needed, such as the size of the team, industry context, existing structure, goals, or time constraints.\n"
              "\nStructure your answers clearly and concisely. Offer direct, actionable recommendations that are easy to understand and implement.\n"
              "\nWhen users ask:\n"
              "\n- If they request help with team leadership → provide clear steps or frameworks (e.g., situational leadership, SMART goals, etc.)."
              "\n- If they ask about improving performance → suggest practical KPIs, feedback techniques, or delegation strategies."
              "\n- If they ask how to structure roles or assign responsibilities → recommend proven models like RACI, OKRs, or job matrix."
              "\n- If they mention a problem without detail → ask polite, specific questions to better understand the situation before answering.\n"
              "\nStay focused on management-related topics. If the question is outside your domain, politely redirect the user to ask something related to leadership, strategy, or organizational management.\n"
              "\nRespond in a confident, professional, and supportive tone that builds trust and encourages good decision-making."
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
        backgroundColor: Colors.deepOrangeAccent,
        leading: Image.asset("assets/NDT1.png"),
        title: Text("AI Boudi ", style: TextStyle(color: Colors.white)),
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
                          currentUserContainerColor: Colors.deepOrangeAccent,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/NDT1.png",
                            width: 250,
                            height: 250,
                          ),
                          Text(
                            "Hello L'Boudi!",
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
                                      "What is digital product";
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
                                      "Digital Product",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  textEditingController.text =
                                      "How do I become rich?";
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
                                      "Money",
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
                        icon: Icon(
                          Icons.send_sharp,
                          color: Colors.deepOrangeAccent,
                        ),
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
