

import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/mtaToast.dart';
import 'MTAResult.dart';

class  MTAInternetConnectivity
{

  Future<bool> IsConnectedToInternet() async
  {
    bool bResult=false;
    try {
      MTAResult objMTAResult=await IsInternetAvailable();
      if(objMTAResult.IsResultPass==false) {
        String strMessage = objMTAResult.ErrorMessage;
        MTAToast().ShowToast(strMessage);
        return false;
      }
      else
        {
          bResult=true;
        }
        }
    on Exception {
      bResult=false;
    }

    return bResult;
  }

    Future<MTAResult>  IsInternetAvailable() async
    {
      MTAResult objMTAResult=MTAResult();

      String strMessage='No internet connection';
      objMTAResult.IsResultPass=false;
      objMTAResult.ErrorMessage=strMessage;
        try
           {
             final connectivityResult = await (Connectivity().checkConnectivity());
             if (connectivityResult == ConnectivityResult.mobile) {
               strMessage='connected to a mobile network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;

             } else if (connectivityResult == ConnectivityResult.wifi) {
               strMessage='connected to a wifi network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;
             } else if (connectivityResult == ConnectivityResult.ethernet) {
               strMessage='connected to an ethernet network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;
             } else if (connectivityResult == ConnectivityResult.vpn) {
               // Note for iOS and macOS:
               // There is no separate network interface type for [vpn].
               // It returns [other] on any device (also simulator)
               strMessage='connected to a vpn network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;
             } else if (connectivityResult == ConnectivityResult.bluetooth) {
               strMessage='connected to a bluetooth network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;
             } else if (connectivityResult == ConnectivityResult.other) {
               strMessage='connected to a other network';
               objMTAResult.IsResultPass=true;
               objMTAResult.ErrorMessage='';
               objMTAResult.ResultMessage=strMessage;
               // I am connected to a network which is not in the above mentioned networks.
             } else if (connectivityResult == ConnectivityResult.none) {
               strMessage='No internet connection';
               objMTAResult.IsResultPass=false;
               objMTAResult.ErrorMessage=strMessage;
             }

           }
        on Exception catch(e)
          {
            objMTAResult=MTAResult();
            objMTAResult.IsResultPass=false;
            objMTAResult.ErrorMessage=e.toString();
          }
        return objMTAResult;
    }




}