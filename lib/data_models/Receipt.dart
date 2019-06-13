class Receipt {
  String _recpt_id = "";
  String _uid = "";
  String _time_stamp = "";
  double _total = 0;
  String _merchant = "";
  String _dateTime = "";
  String _category = "";
  bool _isPapyrus = false;
  String _imagePath = "";
  String _address = "";
  List<ReceiptItem> _items = [
    // new ReceiptItem("Im Nayeon", 2, 1500.0),
    // new ReceiptItem("Yoo Jeongyeon", 2, 1500.0),
    // new ReceiptItem("Hirai Momo", 2, 1500.0),
    // new ReceiptItem("Minatozaki Sana", 2, 1500.0),
    // new ReceiptItem("Park Jihyo", 2, 1500.0),
    // new ReceiptItem("Myoui Mina", 2, 1500.0),
    // new ReceiptItem("Kim Dahyun", 2, 1500.0),
    // new ReceiptItem("Son Chaeyoung", 2, 1500.0),
    // new ReceiptItem("Chou Tzuyu", 2, 1500.0),
  ];

  // Receipt(this._recpt_id, this._uid, this._time_stamp, this._merchant, this._category, this._dateTime,this._isPapyrus,this._items ){
  //   updateReceipt();
  // }

  Receipt();

  String get recpt_id => _recpt_id;
  bool get isPapyrus => _isPapyrus;
  String get uid => _uid;
  String get address => _address;
  String get time_stamp => _time_stamp;
  String get merchant => _merchant;
  String get dateTime => _dateTime;
  String get category => _category;
  List<ReceiptItem> get items => _items;
  double get total => _total;

  String get imagePath => _imagePath;
  set imagePath(String path) => _imagePath = path;
  set address(String add) => _address = add;
  set total(double tot) => _total = tot;
  set recpt_id(String id) => _recpt_id = id;
  set isPapyrus(bool val) => _isPapyrus = val;
  set uid(String id) => _uid = id;
  set time_stamp(String ts) => _time_stamp = ts;
  set merchant(String mer) => _merchant = mer;
  set category(String cat) => _category = cat;
  set dateTime(String dt) => _dateTime = dt;
  set items(List<ReceiptItem> i) => _items = i;

  void addReceiptItem(ReceiptItem recptItem) {
    _items.add(recptItem);
    updateReceipt();
  }

  void removeReceiptItem(ReceiptItem recptItem) {
    _items.remove(recptItem);
    updateReceipt();
  }

  void updateReceipt() {
    double tot = 0;

    for (var i = 0; i < _items.length; i++) {
      tot += _items[i].total;
    }

    _total = tot;
  }

  void updateReceiptItem(ReceiptItem recptItem) {
    // _total =
    // _items.
  }

  void displayItems() {
    print("displaying" + _items.length.toString());
    _items.map((i) {
      // print("item: "+i.name +" " + i.price.toString() + " " + i.total.toString());
    });
  }

  Map<String, dynamic> toJson() => {
        'recpt_id': _recpt_id,
        'uid': _uid,
        'time_stamp': _time_stamp,
        "total": _total,
        "merchant": _merchant,
        "dateTime": _dateTime,
        "category": _category,
        "isPapyrus": _isPapyrus,
        "imagePath": _imagePath,
        "address": _address,
        "items": _items.map((f)=>f.toJson() ).toList(),
      };
  factory Receipt.fromJson(Map<String, dynamic> json) {
    var r = Receipt()
      ..recpt_id = json['recpt_id']
      ..uid = json['uid']
      ..time_stamp = json['time_stamp']
      ..total = json['total']
      ..merchant = json['merchant']
      ..dateTime = json['dateTime']
      ..category = json['category']
      ..isPapyrus = json['isPapyrus']
      ..imagePath = json['imagePath']
      ..address = json['address'];
    var list = json['items'] as List;
    if (list.length > 0) {
      List<ReceiptItem> rList =
          list.map((i) => ReceiptItem.fromJson(i)).toList();
          r.items = rList;
    }
    else r.items = <ReceiptItem> [] ;
    // r.items = rList;
    return r;
  }
// {List<ReceiptItem> r}
  // _items = (json['items']).map((i){return ReceiptItem.fromJson(i);}).toList()<ReceiptItem>;
//     List<ReceiptItem> l = _items.map((i)=>ReceiptItem.fromJson(i).toList() );
// List<ReceiptItem> imagesList = _items.map((i) => ReceiptItem.fromJson(i)).toList();

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

  Map<String, dynamic> toJson() => {
        "name": _name,
        "qty": _qty,
        "price": _price,
        "total": _total,
      };

  ReceiptItem.fromJson(Map<String, dynamic> json)
      : _name = json["name"],
        _qty = json['qty'],
        _price = json['price'],
        _total = json['total'];

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
