import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget { 
  const HomePage({super.key});

  @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id:"1",
     firstName: "Gemini",
     profileImage:"https://seeklogo.com/images/G/google-gemini-logo-AS78782669-seeklogo.com.png",
     );

  @override
   Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Women and girls healthcare"
            ),
          ),
          body: _buildUI(),
        );
      }

      Widget _buildUI() {
        return DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
              onPressed: _sendMediaMessage, 
            icon:const Icon(
             Icons.image,
            )
            )
          ]),
          currentUser:currentUser, 
          onSend: _sendMessage, 
          messages: messages,
          );
      }
      void _sendMessage(ChatMessage chatMessage) {
        setState(() {
          messages = [chatMessage, ...messages];
        });
        try {
          String question = chatMessage.text;
          List<Uint8List>? images;
          if (chatMessage.medias?.isNotEmpty ?? false) {
           images = [
            File(chatMessage.medias!.first.url).readAsBytesSync(),
           ];
          }
          gemini
          .streamGenerateContent(
            question, 
            images: images,
            )
            .listen((event) {
            ChatMessage? lastMessage = messages.firstOrNull;
            if (lastMessage != null && lastMessage.user == geminiUser) {
              lastMessage = messages.removeAt(0);
              String response = event.content?.parts
              ?.fold("", (previous, current) => "$previous ${current.text}") ??
              "";
              lastMessage.text += response;
              setState(() {
                messages = [lastMessage!, ...messages];
              },
              );

            }else{
              String response = event.content?.parts
              ?.fold("", (previous, current) => "$previous ${current.text}") ?? 
              "";
              ChatMessage message = chatMessage
              (user: geminiUser, createdAt: DateTime.now(), 
              text: response,
              );
              setState(() {
                messages = [message, ...messages];
              });
            }
           });
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
      }
      
      // ignore: non_constant_identifier_names
      void _sendMediaMessage(ImageSource, MediaType) async {
        ImagePicker picker = ImagePicker();
        XFile? file = await picker.pickImage(
          source: ImageSource.gallery,
          );
          if (file != null) {
            ChatMessage chatMessage = ChatMessage(
              user: currentUser, 
              createdAt: DateTime.now(), 
              text:"Describe this picture?",
              medias: [
                 ChatMedia(
                  url: file.path, 
                  fileName: "", 
                  type: MediaType.image,
                )
              ],
             );
             _sendMessage(chatMessage);
          }
         }
        }


  

//import com.google.ai.client.generativeai.GenerativeModel

//val model = GenerativeModel(
  //"gemini-1.5-flash",
  // Retrieve API key as an environmental variable defined in a Build Configuration
  // see https://github.com/google/secrets-gradle-plugin for further instructions
  //BuildConfig.geminiApiKey,
  //generationConfig = generationConfig {
   // temperature = 1f
   // topK = 40
    //topP = 0.95f
    //maxOutputTokens = 8192
   // responseMimeType = "text/plain"
  //},
//)

//val chatHistory = listOf(
  //content("user") {
    //text("women and girls healthcare")
  //},
  //content("model") {
   // text("## Women and Girls Healthcare: A Complex and Crucial Topic\n\nWomen and girls' healthcare encompasses a wide range of needs and concerns, spanning from reproductive health to mental health and beyond. It's crucial to recognize the unique challenges and opportunities facing women and girls in accessing quality healthcare. \n\nHere's a breakdown of key areas:\n\n**Reproductive Health:**\n\n* **Menstrual health:**  This includes understanding the menstrual cycle, managing menstrual symptoms, and accessing safe and effective period products.\n* **Contraception:**  Offering comprehensive information and access to various contraceptive methods is vital for family planning and preventing unintended pregnancies.\n* **Pregnancy and childbirth:**  Providing prenatal care, safe delivery services, and postpartum support is essential for the health of mothers and babies.\n* **Sexual health:**  This encompasses education about sexually transmitted infections (STIs), safe sex practices, and access to testing and treatment.\n* **Infertility:**  Providing support and resources for women facing infertility is crucial.\n\n**Other Health Concerns:**\n\n* **Mental health:**  Addressing mental health issues like anxiety, depression, and postpartum depression in women and girls is vital.\n* **Heart health:**  Women are more likely to experience heart attacks with different symptoms than men.\n* **Cancer:**  Women are at risk for specific cancers like breast and cervical cancer.\n* **Chronic conditions:**  Managing chronic conditions like diabetes, arthritis, and autoimmune diseases requires specialized care.\n\n**Barriers to Access:**\n\n* **Financial constraints:**  Healthcare costs can be a significant barrier for many women and girls.\n* **Lack of insurance coverage:**  Insurance gaps can limit access to essential services.\n* **Geographic disparities:**  Access to quality healthcare can be limited in rural areas and underserved communities.\n* **Cultural and social norms:**  Stigma and cultural barriers can prevent women and girls from seeking necessary care.\n* **Discrimination and bias:**  Women and girls may experience discrimination based on race, ethnicity, sexual orientation, gender identity, or socioeconomic status.\n\n**Solutions and Opportunities:**\n\n* **Improving access to affordable healthcare:**  Expanding insurance coverage, providing financial assistance, and creating community health centers can help address access barriers.\n* **Promoting health education:**  Providing comprehensive sex education, mental health awareness campaigns, and disease prevention programs can empower women and girls.\n* **Addressing systemic biases:**  Recognizing and challenging discriminatory practices in healthcare can create a more equitable system.\n* **Empowering women and girls:**  Supporting women's leadership in healthcare and encouraging their participation in health decisions can improve outcomes.\n* **Investing in research:**  Research focused on understanding women and girls' unique health needs is essential for developing targeted interventions and treatments.\n\n**It's essential to address the complex intersection of factors influencing women and girls' health, creating a more equitable and supportive healthcare system for all.** \n")
  //},
//)

//val chat = model.startChat(chatHistory)

// Note that sendMessage() is a suspend function and should be called from
// a coroutine scope or another suspend function
//val response = chat.sendMessage("INSERT_INPUT_HERE")

// Get the first text part of the first candidate
//println(response.text)
// Alternatively
//println(response.candidates.first().content.parts.first().asTextOrNull())

      // second

//AIzaSyDE4iFqQdDvqGunThk3JkMPy52GH_MLVLI

      //third
//import 'package:google_generative_ai/google_generative_ai.dart';

// Access your API key as an environment variable (see "Set up your API key" above)
//final apiKey = Platform.environment['API_KEY'];
//if (apiKey == null) {
  //print('No \$API_KEY environment variable');
 // exit(1);
//}


      //  forth

// Make sure to include this import:
// import 'package:google_generative_ai/google_generative_ai.dart';
//final model = GenerativeModel(
  //model: 'gemini-1.5-flash',
  //apiKey: apiKey,
//);
//final prompt = 'Write a story about a magic backpack.';

//final response = await model.generateContent([Content.text(prompt)]);
//print(response.text);


   //fifth
//video code
// Make sure to include this import:
// import 'package:google_generative_ai/google_generative_ai.dart';
//final model = GenerativeModel(
 // model: 'gemini-1.5-flash',
  //apiKey: apiKey,
//);
//final prompt = 'Write a story about a magic backpack.';

//final response = await model.generateContent([Content.text(prompt)]);
//print(response.text);