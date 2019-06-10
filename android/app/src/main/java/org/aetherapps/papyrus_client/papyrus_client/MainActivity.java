package org.aetherapps.papyrus_client.papyrus_client;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.widget.Toast;

import java.io.File;
import java.lang.reflect.Method;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.native/helper";
  private static final String CONNECT_WIFI_CHANNEL = "papyrus_client/connectWifi";
  protected static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 1;

    Client client;

    private String scanned_hotspotSSID;
    private String scanned_hotspotPSK;
    private String scanned_device_ip;
    private WifiManager wifiManager;
    private WifiConfiguration wifiConfiguration;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);


    new MethodChannel(getFlutterView(), CONNECT_WIFI_CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                // if (call.method.equals("helloFromNativeCode")) {
                //   String greetings = helloFromNativeCode();
                //   result.success(greetings);
                // }

                if(call.method.equals("initializeConnection")){
                  System.out.print("good wifi is good");

                  initializeConnection("AndroidWifi", "");

                }
 



              }});
  }

    private void initializeWifi() {
        wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        wifiConfiguration = new WifiConfiguration();

    }
  private void initializeConnection(String SSID, String passkey){

      initializeWifi();
      connectToHotSpot(SSID , passkey);



  }
    private Boolean changeStateWifiAp(boolean activated) {
        Method method;
        try {

            method = wifiManager.getClass().getDeclaredMethod("setWifiApEnabled", WifiConfiguration.class, Boolean.TYPE);
            method.invoke(wifiManager, wifiConfiguration, activated);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    private void prepareBeforeConnect() {

//        if (!wifiManager.isWifiEnabled()) {
        wifiManager.setWifiEnabled(true);
//        }
        try {
            Method method = wifiManager.getClass().getDeclaredMethod("getWifiApState");
            method.setAccessible(true);
            int apWifiState = (Integer) method.invoke(wifiManager, (Object[]) null);
            if (apWifiState == 13 || apWifiState == 12) {
                changeStateWifiAp(false);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

    }

    private void connectToHotSpot(String SSID, String passKey) {
        prepareBeforeConnect();
        ConnectHotspotAsync cn = new ConnectHotspotAsync(wifiManager, SSID, passKey);
        cn.execute();
//        MainActivity.ConnectHotspotThread cn = new MainActivity.ConnectHotspotThread(wifiManager, SSID, passKey);
//        cn.start();
//      new ConnectHotspotTask().execute();


    }
  private String helloFromNativeCode() {
//    Toast.makeText(getApplicationContext(), "hello", Toast.LENGTH_LONG);
    Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
    if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
      startActivityForResult(takePictureIntent, 1);
    }
    return "Hello from Native Android Code";
  }


    private void startClient(String ip) {

//        client = new Client(ip, 5050, this, invoicesPath);
        client.start();



    }

    class ConnectHotspotAsync extends AsyncTask<Void, Void, Void> {
        WifiManager wifiManager;
        String SSID;
        String passKey;
        WifiConfiguration wifiConfig;

        public ConnectHotspotAsync(WifiManager wifiManager, String SSID, String passKey) {
            super();
            this.wifiManager = wifiManager;
            this.SSID = SSID;
            this.passKey = passKey;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();

            wifiConfig = new WifiConfiguration();
            wifiConfig.SSID = String.format("\"%s\"", SSID);
            // wifiConfig.preSharedKey = String.format("\"%s\"", passKey);
            // wifiConfig.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.WPA_PSK);
            wifiConfig.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.NONE);

//        dialog = new ProgressDialog(MainActivity.this);
//        dialog.setMessage("Connecting");
//        dialog.setIndeterminate(false);
//        dialog.setCancelable(false);
//        dialog.show();

        }


        @Override
        protected Void doInBackground(Void... voids) {

            int netId = wifiManager.addNetwork(wifiConfig);
            while (netId == -1) {
                wifiConfig = new WifiConfiguration();
                wifiConfig.SSID = String.format("\"%s\"", SSID);
                // wifiConfig.preSharedKey = String.format("\"%s\"", passKey);
                // wifiConfig.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.WPA_PSK);
                wifiConfig.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.NONE);

                System.out.println("SSID:" + SSID + " PSK:" + passKey);
                netId = wifiManager.addNetwork(wifiConfig);
            }
            wifiManager.enableNetwork(netId, true);
            wifiManager.reconnect();
            WifiInfo info = wifiManager.getConnectionInfo();
            String ssid = info.getSSID();
            Boolean connected = isConnectedViaWifi();
            while (!connected) {
                connected = isConnectedViaWifi();
//                info = wifiManager.getConnectionInfo ();
//                ssid  = info.getSSID();
//                System.out.println("ssid battle" + ssid +" "+ scanned_hotspotSSID);
            }
              // this.
            return null;
        }


        @Override
        protected void onPostExecute(Void aVoid) {
            System.out.println("connected to wifi from native idiots");
            super.onPostExecute(aVoid);
            // dialog.hide();
            // Toast.makeText(this, "connected to wifi", Toast.LENGTH_SHORT).show();
//            startClient(scanned_device_ip);


        }


        private boolean isConnectedViaWifi() {
            ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo mWifi = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
            System.out.println("Connected?: "+ mWifi.isConnected());
            return mWifi.isConnected();
        }

    }



    // private String takeReceiptPhoto(){
  //   Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
  //   Uri imageUri = Uri.fromFile(new File(Environment.getExternalStorageDirectory(),"receipt_" +
  //           String.valueOf(System.currentTimeMillis()) + ".jpg"));
  //   intent.putExtra(android.provider.MediaStore.EXTRA_OUTPUT, imageUri);
  //   startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);


  // }
}

