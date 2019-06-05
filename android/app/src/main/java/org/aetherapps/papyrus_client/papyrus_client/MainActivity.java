package org.aetherapps.papyrus_client.papyrus_client;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.widget.Toast;

import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.native/helper";
  protected static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 1;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);


    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("helloFromNativeCode")) {
                  String greetings = helloFromNativeCode();
                  result.success(greetings);
                }

                if(call.method.equals("takeReceiptPhoto")){




                }



              }});
  }
  private String helloFromNativeCode() {
//    Toast.makeText(getApplicationContext(), "hello", Toast.LENGTH_LONG);
    Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
    if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
      startActivityForResult(takePictureIntent, 1);
    }
    return "Hello from Native Android Code";
  }

  // private String takeReceiptPhoto(){
  //   Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
  //   Uri imageUri = Uri.fromFile(new File(Environment.getExternalStorageDirectory(),"receipt_" +
  //           String.valueOf(System.currentTimeMillis()) + ".jpg"));
  //   intent.putExtra(android.provider.MediaStore.EXTRA_OUTPUT, imageUri);
  //   startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);


  // }
}