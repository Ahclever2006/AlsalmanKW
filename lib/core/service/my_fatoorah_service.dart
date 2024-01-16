import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

import '../../res/style/app_colors.dart';

abstract class MyFatoorahService {
  void init(ValueChanged<List<PaymentMethods>?> onSuccess);
}

class MyFatoorahServiceImpl implements MyFatoorahService {
  @override
  void init(ValueChanged<List<PaymentMethods>?> onSuccess) {
    MFSDK.init(
        //TODO: live token to be uncommented before release
        "c3id0qOJuvwPI_dTSf3xdiZao7OknRGNLom8dJSqn3NriWbYirSAynUjnicFG7qa9WVORdgoiaLp-aLQM9eL_hUSO56vtvdClDvFTscCGyUh_MU3nO5ptAqdoqYzmbB5Z9XxiB6RvDPrp0y6VB7qd2oFcaU8HYs_9NvU94xHFdJp67UXI_KwgFV5aGRIqTnRMYxe9sjnyIXQg4ze52YSUar0d_N1gogTgwQqzydkSUSisyBdyAgSjGY8apVtxu0FiEy85heMYzpIAHyT0823LHKRthr9Ayw7cDOHZ9288CSRzCIIy9FVJUBEe7Q6aTKyF5TxFiMvMtfQNmrAc4Xe5b16Hl0EPllALSd2xoEh2BKWa-s7CCkAcCGBbIai-UuTOxnyA47TkN3xzMERCwzH5_NNELajrBcrryyaKFW8oQuo-04oF2k2hafuNMGIPXxtiiVW_tqRnvvPCt-g2jWGQkOQdRixagX_QttEB8aMqV8sFCTPTclkQCrECwSA_0tauk3i6YBHbcX1PmbS-Rwi6Z3kprQPtI5WU_eYw6o7IpAs_LsF_y72UOzKBhM9082rVkeGdR5iHlECSNuWZSbpzhcMOiqD7KELF_25Gi4kLXU2E4Is5BYxIwWSrAoBe7Cbp_asnxPfxcHtGOt60DN3t4O3dWALo1UX_O3dIn3Yezkd_OPtTUwnls3nVdcflt-MF1iwhSsLjtWEIVSnNBL-Bh2qW1ZFw83QmNQ9Ygn9xkNsDHxm",

        //TODO: test token to be commented before release
        //"rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
        MFCountry.KUWAIT,

        //TODO: change to live mode before release
        MFEnvironment.LIVE);

    MFSDK.setUpAppBar(
        title: "MyFatoorah Payment",
        titleColor: Colors.white,
        backgroundColor: AppColors.PRIMARY_COLOR_DARK,
        isShowAppBar: true);

    var request = MFInitiatePaymentRequest(0.100, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(request, MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) {
      return {
        if (result.isSuccess())
          onSuccess(result.response!.paymentMethods)
        else
          {log(result.error!.message.toString())}
      };
    });
  }
}
