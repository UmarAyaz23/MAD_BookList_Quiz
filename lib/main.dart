import 'package:flutter/material.dart';

void main() {
  runApp(const Start());
}

List<String> cartItems = [];

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD BookList Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const AuthenticationPage(),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  List<Map<String, dynamic>> credentials = [
    {'rollNumber': '22FA008CS', 'password': 'umar'},
    {'rollNumber': '22FA018CS', 'password': 'saaniya'},
    {'rollNumber': '22FA019CS', 'password': 'anuf'},
    {'rollNumber': '22FA026CS', 'password': 'zeeshan'},
  ];

  final TextEditingController _rollNum = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _rollNum,
                decoration: const InputDecoration(
                  label: Text("Roll Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  bool correct = credentials.any((cred) =>
                      _rollNum.text == cred['rollNumber'] && _pass.text == cred['password']);

                  if (correct) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Sign In", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> drawerOptions = ["Find a Book", "Issue a Book", "Publish a Book"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAD BookList Quiz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        ],
      ),

      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                backgroundImage: AssetImage("assets/example.jpg"),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: drawerOptions.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blueGrey, width: 1),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        title: Text(
                          drawerOptions[index],
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          if (drawerOptions[index] == "Issue a Book") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IssueBookPage(onItemAdded: () {
                                  setState(() {});
                                }),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Feature Unimplemented")),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),

      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey,),),
              ),
              SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blueGrey, width: 1),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        title: Text(cartItems[index], style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black,),
                        ),
                      )
                    );
                  },
                ),
              ),

              SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Book Options"),
                        content: Text("Thank you for your purchase"),
                      );
                    },
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class IssueBookPage extends StatelessWidget {
  final VoidCallback onItemAdded;
  IssueBookPage({super.key, required this.onItemAdded});

  final List<String> bookList = ["Book 01", "Book 02", "Book 03", "Book 04", "Book 05", "Book 06", "Book 07", "Book 08"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAD BookList Quiz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bookList.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(bookList[index]),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Book Options"),
                    content: Text("Would you like to ${bookList[index]} add to cart?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cartItems.add(bookList[index]);
                          onItemAdded();
                          Navigator.pop(context);
                        },
                        child: const Text("Add to Cart"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
