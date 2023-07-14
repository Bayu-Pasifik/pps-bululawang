import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pps_bululawang/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF2E2E2E),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: context.height / 3.5,
                    width: context.width,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/background.jpg",
                            ),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Text(
                        "PPS Bululawang E-Mails",
                        style: GoogleFonts.prompt(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: context.width,
                      height: context.height,
                      color: const Color(0XFF2E2E2E),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 70, left: 30),
                            child: Text(
                              "Menu",
                              style: GoogleFonts.prompt(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.SURAT_MASUK),
                                child: Material(
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0XFF2E2E2E),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: const Color(0XFF2E2E2E),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/email.png",
                                            ),
                                            fit: BoxFit.none),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "Surat Masuk",
                                          style: GoogleFonts.prompt(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.SURAT_KELUAR),
                                child: Material(
                                  elevation: 15,
                                  color: const Color(0XFF2E2E2E),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: const Color(0XFF2E2E2E),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/open-email.png",
                                            ),
                                            fit: BoxFit.none),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "Surat Keluar",
                                          style: GoogleFonts.prompt(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 160,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 60,
                  width: context.width,
                  // color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 10,
                          color: const Color(0XFF2E2E2E),
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                color: const Color(0XFF2E2E2E),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "19",
                                    style: GoogleFonts.prompt(
                                        color: const Color.fromARGB(
                                            255, 34, 156, 250),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Jumlah surat masuk",
                                    style: GoogleFonts.prompt(
                                        color: Colors.white, fontSize: 11),
                                  )
                                ]),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          color: const Color(0XFF2E2E2E),
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                color: const Color(0XFF2E2E2E),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "10",
                                    style: GoogleFonts.prompt(
                                        color: const Color.fromARGB(
                                            255, 34, 156, 250),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Jumlah surat Keluar",
                                    style: GoogleFonts.prompt(
                                        color: Colors.white, fontSize: 11),
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
