class BankAccount {
  final int _accID;           
  final String _accUsername;  
  double _balance;            
  final String _accountType;  

  BankAccount(this._accID, this._accUsername, this._balance, this._accountType);

  // Get methods
  double get balance {
    return _balance;
  }
  
  int get accID {
    return _accID;
  }
  
  String get accUsername {
    return _accUsername;
  }
  
  String get accType {
    return _accountType;
  }

  // balance method
  double Balance() {
    return _balance;
  }

  // withdraw method
  double Withdraw(double amount) {
    if (_balance >= amount) {  
      _balance -= amount;
    } else {
      print("Insufficient balance for withdraw");
    }
    return _balance;
  }

  // Method to credit
  double Credit(double amount) {
    _balance += amount;
    return _balance;
  }
}

// Class Bank
class Bank {
  final String _bankName;                   
  List<BankAccount> bankAccounts = [];       

  Bank(this._bankName);

  // Get method
  String get bankName { 
    return _bankName;
  }

  // create account method  
  BankAccount createAccount(int accountId, String accountOwner) { 
    for (var account in bankAccounts) {
      if (account.accID == accountId) { 
        print("Account with ID $accountId already exists."); 
        return account; 
      }
    }
    BankAccount Newacc = BankAccount(accountId, accountOwner, 0.0, "Saving account");
    bankAccounts.add(Newacc); 
    print("Account created successfully for $accountOwner."); 
    return Newacc; 
  }
}

void main() {
  Bank myBank = Bank("ABA");
  BankAccount narongAcc = myBank.createAccount(100, 'Narong');
  print(narongAcc.balance); // Initial balance: $0
  narongAcc.Credit(100); // Credit $100
  print(narongAcc.balance); // Balance after credit: $100
  narongAcc.Withdraw(50);
  print(narongAcc.balance); // Balance: $50
   try {
    narongAcc.Withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}




