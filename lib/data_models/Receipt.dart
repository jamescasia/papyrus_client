class Receipt {
  String _recpt_id;
  String _uid;
  String _time_stamp;

  String _merchant;
  String _dateTime;
  String _category;

  List<ReceiptItem> _items = [
    new ReceiptItem("Det Pikachu!", 2, 1500.0),

    new ReceiptItem("Endgame", 2, 1500.0),

    new ReceiptItem("LOTR", 2, 1500.0),
    // new Receipt(_uid)
  ];

  String get recpt_id => _recpt_id;
  String get uid => _uid;
  String get time_stamp => _time_stamp;
  String get merchant => _merchant;
  String get dateTime => _dateTime;
  String get category => _category;
  List<ReceiptItem> get items => _items;

  set recpt_id(String id) => _recpt_id = id;
  set uid(String id) => _uid = id;
  set time_stamp(String ts) => _time_stamp = ts;
  set merchant(String mer) => _merchant = mer;
  set category(String cat) => _category = cat;
  set dateTime(String dt) => _dateTime = dt;

  void addReceiptItem(ReceiptItem recptItem) {
    print("added");
    _items.add(recptItem);
    displayItems();
  }

  void removeReceiptItem(ReceiptItem recptItem) {
    _items.remove(recptItem);
    displayItems();
    
  }

  void updateReceiptItem(ReceiptItem recptItem){
    // _items.


  }

  void displayItems(){
    print("displaying"+_items.length.toString());
    _items.map((i) { 
      print("item: "+i.name +" " + i.price.toString() + " " + i.total.toString());
    });

  }
}

class ReceiptItem {
  String _name;
  int _qty;
  double _price;
  double _total;
  ReceiptItem(this._name, this._qty, this._price) {
    // print('what'+name);
    this._total = this._price * this._qty;
  }

  
  // List<ReceiptItem> get items => _items;
  // set recpt_id(String id) => _recpt_id = id;

  String get name => _name;
  int get qty => _qty;
  double get price => _price;
  double get total => _total;

  set name(String n) => _name = n;
  set qty(int q) => _qty = q;
  set price(double p) => _price = p;
  set total(double t) => _total = t;


}
