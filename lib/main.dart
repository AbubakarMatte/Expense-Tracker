

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // Import to handle JSON encoding and decoding
// import 'profile.dart';

// void main() {
//   runApp(ExpenseTrackerApp());
// }

// class ExpenseTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ExpenseTrackerHome(),
//     );
//   }
// }

// class ExpenseTrackerHome extends StatefulWidget {
//   @override
//   _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
// }

// class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
//   double totalBalance = 0.00;
//   double income = 5000.00;
//   double expenses = 0.00;
//   String profileName = 'Abubakar';
//   String profilePhone = '9876543210';
//   String profileEmail = 'abubakar.cs22@bmsce.ac.in';
//   String profileImage = 'assets/profile1.jpg'; // Default profile image

//   List<Map<String, dynamic>> transactions = [
//     {'name': 'Food', 'amount': -45.00, 'date': 'Today', 'icon': Icons.fastfood.codePoint},
//     {'name': 'Shopping', 'amount': -230.00, 'date': 'Today', 'icon': Icons.shopping_bag.codePoint},
//     {'name': 'Health', 'amount': -79.00, 'date': 'Yesterday', 'icon': Icons.health_and_safety.codePoint},
//     {'name': 'Travel', 'amount': -350.00, 'date': 'Yesterday', 'icon': Icons.travel_explore.codePoint},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadProfileDetails();
//     _loadTransactions();
//   }

//   Future<void> _loadProfileDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       profileName = prefs.getString('profileName') ?? 'Abubakar';
//       profilePhone = prefs.getString('profilePhone') ?? '9876543210';
//       profileEmail = prefs.getString('profileEmail') ?? 'abubakar.cs22@bmsce.ac.in';
//       profileImage = prefs.getString('profileImage') ?? 'assets/profile1.jpg';
//     });
//   }

//   Future<void> _saveProfileDetails(String name, String phone, String email, String image) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('profileName', name);
//     await prefs.setString('profilePhone', phone);
//     await prefs.setString('profileEmail', email);
//     await prefs.setString('profileImage', image);
//   }

//   Future<void> _loadTransactions() async {
//     final prefs = await SharedPreferences.getInstance();
//     final transactionsData = prefs.getStringList('transactions') ?? [];
//     setState(() {
//       transactions = transactionsData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   Future<void> _saveTransactions() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('transactions', transactions.map((e) => jsonEncode(e)).toList());
//   }

//   void _addTransaction(String name, double amount, IconData icon) {
//     setState(() {
//       transactions.add({'name': name, 'amount': amount, 'date': 'Today', 'icon': icon.codePoint});
//       totalBalance += amount;
//       if (amount > 0) {
//         income += amount;
//       } else {
//         expenses -= amount;
//       }
//     });
//     _saveTransactions();
//   }

//   void _deleteTransaction(int index) {
//     setState(() {
//       double amount = transactions[index]['amount'];
//       transactions.removeAt(index);
//       totalBalance -= amount;
//       if (amount > 0) {
//         income -= amount;
//       } else {
//         expenses += amount;
//       }
//     });
//     _saveTransactions();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           onTap: () async {
//             final result = await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProfilePage(
//                   initialName: profileName,
//                   initialPhone: profilePhone,
//                   initialEmail: profileEmail,
//                   initialImage: profileImage,
//                 ),
//               ),
//             );
//             if (result != null) {
//               setState(() {
//                 profileName = result['name'];
//                 profilePhone = result['phone'];
//                 profileEmail = result['email'];
//                 profileImage = result['profileImage'];
//               });
//               _saveProfileDetails(profileName, profilePhone, profileEmail, profileImage);
//             }
//           },
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage(profileImage),
//               ),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('HELLO!', style: TextStyle(fontSize: 12)),
//                   Text(profileName, style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Total Balance',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 Text(
//                   '\$${totalBalance.toStringAsFixed(2)}',
//                   style: TextStyle(color: Colors.white, fontSize: 48),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Income\n\$${income.toStringAsFixed(2)}',
//                       style: TextStyle(color: Colors.green, fontSize: 18),
//                     ),
//                     Text(
//                       'Expenses\n\$${expenses.toStringAsFixed(2)}',
//                       style: TextStyle(color: Colors.red, fontSize: 18),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.purple, Colors.pink],
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: transactions.length,
//               itemBuilder: (context, index) {
//                 final transaction = transactions[index];
//                 return ListTile(
//                   leading: Icon(IconData(transaction['icon'], fontFamily: 'MaterialIcons')),
//                   title: Text(transaction['name']),
//                   subtitle: Text(transaction['date']),
//                   trailing: Text(
//                     transaction['amount'].toStringAsFixed(2),
//                     style: TextStyle(
//                       color: transaction['amount'] < 0 ? Colors.red : Colors.green,
//                     ),
//                   ),
//                   onLongPress: () => _deleteTransaction(index),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _startAddNewTransaction(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _startAddNewTransaction(BuildContext ctx) {
//     showModalBottomSheet(
//       context: ctx,
//       builder: (_) {
//         return GestureDetector(
//           onTap: () {},
//           child: NewTransaction(_addTransaction),
//           behavior: HitTestBehavior.opaque,
//         );
//       },
//     );
//   }
// }

// class NewTransaction extends StatefulWidget {
//   final Function addTx;

//   NewTransaction(this.addTx);

//   @override
//   _NewTransactionState createState() => _NewTransactionState();
// }

// class _NewTransactionState extends State<NewTransaction> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   void _submitData() {
//     final enteredName = nameController.text;
//     final enteredAmount = double.tryParse(amountController.text) ?? 0.0;

//     if (enteredName.isEmpty || enteredAmount <= 0) {
//       return;
//     }

//     widget.addTx(
//       enteredName,
//       enteredAmount,
//       Icons.attach_money, // Default icon
//     );

//     Navigator.of(context).pop();
//   }

//   void _showIconSelectionDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select Icon'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.fastfood),
//                   title: Text('Food'),
//                   onTap: () {
//                     widget.addTx(
//                       nameController.text,
//                       double.tryParse(amountController.text) ?? 0.0,
//                       Icons.fastfood,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.shopping_bag),
//                   title: Text('Shopping'),
//                   onTap: () {
//                     widget.addTx(
//                       nameController.text,
//                       double.tryParse(amountController.text) ?? 0.0,
//                       Icons.shopping_bag,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.health_and_safety),
//                   title: Text('Health'),
//                   onTap: () {
//                     widget.addTx(
//                       nameController.text,
//                       double.tryParse(amountController.text) ?? 0.0,
//                       Icons.health_and_safety,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.travel_explore),
//                   title: Text('Travel'),
//                   onTap: () {
//                     widget.addTx(
//                       nameController.text,
//                       double.tryParse(amountController.text) ?? 0.0,
//                       Icons.travel_explore,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 // Add more icons here as needed
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Name'),
//               controller: nameController,
//               onSubmitted: (_) => _submitData(),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Amount'),
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               onSubmitted: (_) => _submitData(),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showIconSelectionDialog(context),
//               child: Text('Select Icon'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitData,
//               child: Text('Add Transaction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// main.dart
// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import to handle JSON encoding and decoding
import 'profile.dart';
import 'help_page.dart'; // Import the help page

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseTrackerHome(),
    );
  }
}

class ExpenseTrackerHome extends StatefulWidget {
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  double totalBalance = 0.00;
  double income = 0.00;
  double expenses = 0.00;
  String profileName = 'Abubakar';
  String profilePhone = '9876543210';
  String profileEmail = 'abubakar.cs22@bmsce.ac.in';
  String profileImage = 'assets/profile1.jpg'; // Default profile image

  List<Map<String, dynamic>> transactions = [
    {'name': 'Food', 'amount': -45.00, 'date': 'Today', 'icon': Icons.fastfood.codePoint},
    {'name': 'Shopping', 'amount': -230.00, 'date': 'Today', 'icon': Icons.shopping_bag.codePoint},
    {'name': 'Health', 'amount': -79.00, 'date': 'Yesterday', 'icon': Icons.health_and_safety.codePoint},
    {'name': 'Travel', 'amount': -350.00, 'date': 'Yesterday', 'icon': Icons.travel_explore.codePoint},
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileDetails();
    _loadTransactions();
    _promptInitialValues(); // Prompt for initial income and expenses
  }

  Future<void> _promptInitialValues() async {
    await Future.delayed(Duration.zero); // Ensure the prompt runs after the build method
    _showInitialValuesDialog();
  }

  Future<void> _showInitialValuesDialog() async {
    TextEditingController incomeController = TextEditingController();
    TextEditingController expensesController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Set Initial Values'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Income'),
                controller: incomeController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Expenses Budget'),
                controller: expensesController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  income = double.tryParse(incomeController.text) ?? 0.0;
                  expenses = double.tryParse(expensesController.text) ?? 0.0;
                  totalBalance = income - expenses;
                });
                Navigator.of(ctx).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadProfileDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileName = prefs.getString('profileName') ?? 'Abubakar';
      profilePhone = prefs.getString('profilePhone') ?? '9876543210';
      profileEmail = prefs.getString('profileEmail') ?? 'abubakar.cs22@bmsce.ac.in';
      profileImage = prefs.getString('profileImage') ?? 'assets/profile1.jpg';
    });
  }

  Future<void> _saveProfileDetails(String name, String phone, String email, String image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', name);
    await prefs.setString('profilePhone', phone);
    await prefs.setString('profileEmail', email);
    await prefs.setString('profileImage', image);
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsData = prefs.getStringList('transactions') ?? [];
    setState(() {
      transactions = transactionsData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('transactions', transactions.map((e) => jsonEncode(e)).toList());
  }

  void _addTransaction(String name, double amount, IconData icon) {
    setState(() {
      transactions.add({'name': name, 'amount': amount, 'date': 'Today', 'icon': icon.codePoint});
      if (amount < 0) {
        expenses += -amount;
        totalBalance -= -amount;
      } else {
        totalBalance += amount;
      }
      _checkExpenseLimit();
    });
    _saveTransactions();
  }

  void _deleteTransaction(int index) {
    setState(() {
      double amount = transactions[index]['amount'];
      if (amount < 0) {
        expenses -= -amount;
        totalBalance += -amount;
      } else {
        totalBalance -= amount;
      }
      transactions.removeAt(index);
      _checkExpenseLimit();
    });
    _saveTransactions();
  }

  void _checkExpenseLimit() {
    if (expenses >= 0.8 * income) {
      _showExpenseAlert();
    }
  }

  void _showExpenseAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Budget Alert'),
        content: Text('You have reached 80% of your expense budget!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      initialName: profileName,
                      initialPhone: profilePhone,
                      initialEmail: profileEmail,
                      initialImage: profileImage,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    profileName = result['name'];
                    profilePhone = result['phone'];
                    profileEmail = result['email'];
                    profileImage = result['profileImage'];
                  });
                  _saveProfileDetails(profileName, profilePhone, profileEmail, profileImage);
                }
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('HELLO!', style: TextStyle(fontSize: 12)),
                      Text(profileName, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            Text('Expense Tracker'),
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Text(
                  '\$${totalBalance.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Income\n\$${income.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    Text(
                      'Expenses\n\$${expenses.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.pink],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: Icon(IconData(transaction['icon'], fontFamily: 'MaterialIcons')),
                  title: Text(transaction['name']),
                  subtitle: Text(transaction['date']),
                  trailing: Text(
                    transaction['amount'].toStringAsFixed(2),
                    style: TextStyle(
                      color: transaction['amount'] < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  onLongPress: () => _deleteTransaction(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    bottomNavigationBar: Container(
            // color: Colors.black,
            decoration: const BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black, blurRadius: 10)
            ]),
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              elevation: 10.0,
              items: const [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                  label: "Settings",
                  icon: Icon(Icons.settings),
                  backgroundColor: Colors.white,
                )
              ],
            ),),
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _submitData(IconData icon) {
    final enteredName = nameController.text;
    final enteredAmount = double.tryParse(amountController.text) ?? 0.0;

    if (enteredName.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredName,
      -enteredAmount,
      icon,
    );

    Navigator.of(context).pop();
  }

  void _showIconSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Icon'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text('Food'),
                  onTap: () {
                    _submitData(Icons.fastfood);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text('Shopping'),
                  onTap: () {
                    _submitData(Icons.shopping_bag);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.health_and_safety),
                  title: Text('Health'),
                  onTap: () {
                    _submitData(Icons.health_and_safety);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.travel_explore),
                  title: Text('Travel'),
                  onTap: () {
                    _submitData(Icons.travel_explore);
                  },
                ),
                // Add more icons here as needed
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: nameController,
              onSubmitted: (_) => _submitData(Icons.attach_money),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(Icons.attach_money),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showIconSelectionDialog(context),
              child: Text('Select Icon'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitData(Icons.attach_money),
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
