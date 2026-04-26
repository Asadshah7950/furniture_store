import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'firebaseauth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FurnitureStoreApp());
}

class FurnitureStoreApp extends StatelessWidget {
  const FurnitureStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final RxBool _obscureText = true.obs;

  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    // Login Page Icon
                    const Icon(
                      Icons.login,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => TextFormField(
                        obscureText: _obscureText.value,
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              _obscureText.value = !_obscureText.value;
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuthController()
                              .signInWithEmailAndPassword(_emailcontroller.text,
                                  _passwordcontroller.text)
                              .then((value) {
                            if (value != null) {
                              Get.snackbar(
                                'Authentication Message',
                                'Login Successfully',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                'Authentication Message',
                                'Login Failed, Please try again',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          });
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account? "),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.blue[200]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final RxBool _obscureText = true.obs;
  final RxBool _obscureText1 = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Assign the _formKey to the Form widget
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    // SignUp Page Icon
                    const Icon(
                      Icons.person_add,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name :",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Obx(
                      () => TextFormField(
                        obscureText: _obscureText.value,
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              _obscureText.value = !_obscureText.value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => TextFormField(
                        obscureText: _obscureText1.value,
                        controller: _confirmpasswordcontroller,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText1.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              _obscureText1.value = !_obscureText1.value;
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm Password is required";
                          } else if (value != _passwordcontroller.text) {
                            return "Passwords does not match!!!";
                          }
                          return null; // Validation passed
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    OutlinedButton(
                      child: Text("Register"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuthController()
                              .registerWithEmailAndPassword(
                                  _emailcontroller.text,
                                  _passwordcontroller.text)
                              .then((Value) {
                            if (Value != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                              Get.snackbar(
                                'Authentication Message',
                                'Your account has been created successfully',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                'Authentication Message',
                                'Error in creating account',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          });
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an Account! ?"),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.blue[200]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Cart {
  static List<FurnitureItem> items = [];
  static ValueNotifier<int> itemCountNotifier = ValueNotifier(0);
  static List<FurnitureItem> orders = []; // Corrected type

  static void addItem(FurnitureItem item) {
    items.add(item);
    itemCountNotifier.value = items.length;

    Notifications.addNotification("${item.name} added to cart.");
  }

  static void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      String removedItem = items[index].name;
      items.removeAt(index);
      itemCountNotifier.value = items.length;

      Notifications.addNotification("$removedItem removed from cart.");
    }
  }

  static void placeOrder() {
    if (items.isNotEmpty) {
      orders.addAll(items); // Add items to orders
      items.clear(); // Clear the cart
      itemCountNotifier.value = items.length;

      Notifications.addNotification("Order placed successfully!");
    } else {
      Notifications.addNotification("No items in the cart to place an order.");
    }
  }
}

class Notifications {
  static List<String> messages = [];
  static ValueNotifier<int> notificationCount = ValueNotifier(0);

  static void addNotification(String message) {
    messages.add(message);
    notificationCount.value = messages.length;
  }

  static void clearNotifications() {
    messages.clear();
    notificationCount.value = 0;
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Notifications"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear all notifications',
            onPressed: () {
              Notifications.clearNotifications();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All notifications cleared!")),
              );
            },
          ),
        ],
      ),
      body: Notifications.messages.isEmpty
          ? const Center(child: Text("No notifications yet!"))
          : ListView.builder(
              itemCount: Notifications.messages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.notification_important),
                    title: Text(Notifications.messages[index]),
                  ),
                );
              },
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final double totalAmount;

  const CheckoutPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkout Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Cart.placeOrder();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => OrdersPage()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Confirm Order',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuyNowPage extends StatelessWidget {
  final FurnitureItem item;

  const BuyNowPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Now"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buy Now Details",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Item:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Add item to orders
                        Cart.orders.add(item);

                        // Add notification
                        Notifications.addNotification(
                            "Order placed for ${item.name} (\$${item.price.toStringAsFixed(2)}).");

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Order placed successfully!"),
                          ),
                        );

                        // Navigate back after order
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Your Orders"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Cart.orders.isEmpty
          ? const Center(
              child: Text(
                "No orders placed yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: Cart.orders.length,
              itemBuilder: (context, index) {
                final item = Cart.orders[index];
                return ListTile(
                  leading: Image.asset(item.path, width: 50, height: 50),
                  title: Text(item.name),
                  subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                );
              },
            ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FurnitureItem> furnitureItems = [
    FurnitureItem(
      name: "Sofa",
      description: "Comfortable 3-seater sofa.",
      details: "This is a detailed description of the sofa.",
      category: "Living Room",
      path: "assets/sofa.jpeg",
      price: 499.99,
      rating: 4.5,
    ),
    FurnitureItem(
      name: "Dining Table",
      description: "Stylish dining table with 6 chairs.",
      details: "This is a detailed description of the dining table.",
      category: "Dining Room",
      path: "assets/dining.jpg",
      price: 899.99,
      rating: 4.8,
    ),
    FurnitureItem(
      name: "Bed",
      description: "Queen-sized bed with a soft mattress.",
      details: "This is a detailed description of the bed.",
      category: "Bedroom",
      path: "assets/Bed.jpeg",
      price: 699.99,
      rating: 4.6,
    ),
    FurnitureItem(
      name: "Chair",
      description: "Comfortable chair.",
      details: "This is a detailed description of the chair.",
      category: "Office",
      path: "assets/office_chair.jpeg",
      price: 699.99,
      rating: 4.6,
    ),
  ];

  final List<String> categories = [
    "Living Room",
    "Dining Room",
    "Bedroom",
    "Office",
  ];

  String? selectedCategory;
  String searchQuery = "";

  List<FurnitureItem> get filteredItems {
    List<FurnitureItem> items = furnitureItems;
    if (selectedCategory != null) {
      items = items.where((item) => item.category == selectedCategory).toList();
    }
    if (searchQuery.isNotEmpty) {
      items = items
          .where((item) =>
              item.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Furniture Store"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()),
              );
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: Notifications.notificationCount,
            builder: (context, count, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 7,
                      top: 8,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                              fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: ListTile(
                title: Text("All"),
                onTap: () {
                  setState(() {
                    selectedCategory = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ...categories.map((category) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: ListTile(
                  title: Text(category),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            }),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search furniture...',
                suffixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(item: item),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(item.path, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("\$${item.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 16),
                                  Text(item.rating.toString(),
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Cart.addItem(item);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${item.name} added to cart!"),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BuyNowPage(item: item),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Proceed to buy ${item.name}!"),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text('Buy Now',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(width: 2),
                                        Icon(Icons.shopping_cart,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CartButton(), // Using the new StatefulWidget
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
      },
      backgroundColor: Colors.blue,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ValueListenableBuilder<int>(
              valueListenable: Cart.itemCountNotifier,
              builder: (context, itemCount, _) {
                return CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = Cart.items.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Cart.items.isEmpty
          ? Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: Cart.items.length + 1,
              itemBuilder: (context, index) {
                if (index == Cart.items.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
                final item = Cart.items[index];
                return ListTile(
                  leading: Image.asset(item.path, width: 50, height: 50),
                  title: Text(item.name),
                  subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        Cart.removeItem(index); // Remove the item
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(totalAmount: totalAmount),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Proceed to Checkout',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final FurnitureItem item;

  const ProductDetailPage({super.key, required this.item});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.item.path,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),

              // Product Title and Price
              Text(
                widget.item.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "\$${widget.item.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 16),

              // Rating Section
              Row(
                children: [
                  Icon(Icons.star, color: Colors.blue, size: 24),
                  SizedBox(width: 4),
                  Text(
                    widget.item.rating.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "(120 Reviews)", // Example static review count
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Divider(color: Colors.grey[300], thickness: 1),

              // Description Section
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.item.description,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              SizedBox(height: 16),

              // Detailed Information Section
              Text(
                "Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.item.details,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              SizedBox(height: 32),

              // Add to Cart Button
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  Cart.addItem(widget.item); // Use the addItem method
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("${widget.item.name} added to cart!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class FurnitureItem {
  final String name;
  final String description;
  final String details;
  final String category;
  final String path;
  final double price;
  final double rating;

  FurnitureItem({
    required this.name,
    required this.description,
    required this.details,
    required this.category,
    required this.path,
    required this.price,
    required this.rating,
  });
}
