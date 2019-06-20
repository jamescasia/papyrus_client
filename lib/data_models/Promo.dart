class Promo {
  String item_num;
  String type = "DISCOUNT"; 
  String retailer_id;
  String customer_id;
  double value;
  String promo_code;
  bool collected;
  bool expired;

  Promo(this.promo_code, this.item_num, this.type, this.retailer_id, this.customer_id, this.value, this.collected, this.expired);


    Map<String, dynamic> toJson() => {
        "item_num": item_num,
        "type": type,
        "retailer_id": retailer_id,
        "customer_id": customer_id,
        "promo_code": promo_code,
        "expired": expired,
        "collected": collected,

        "value": value,
      };

  Promo.fromJson(Map<String, dynamic> json)
      : item_num = json["item_num"],
        type = json['type'],
        retailer_id = json['retailer_id'],
        customer_id = json['customer_id'],
        promo_code = json['promo_code'],
        collected = json['collected'],
        expired = json['expired'],
        value = json['value'];


  

}
 