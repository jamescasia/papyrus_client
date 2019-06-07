import 'dart:async';


main(){

  print('starts'); 
  printFileContent();
  print('ends');


}

printFileContent() async{
    String fileContent =await downloadAFile();
    print("The content of the file is ---->"+fileContent);
}

Future<String> downloadAFile() {


  Future <String> result = Future.delayed(Duration(seconds:5), (){

    return 'Hello';
  });


  return result;
}