import 'dart:math';

import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_history_page.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/ProfilePage";

  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  bool isDarkTheme = false; // To toggle dark mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            BlocBuilder<PersonalBloc, PersonalState>(
              builder: (context, state) {
                if (state is PersonalLoaded) {
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 100.0,
                      bottom: 24,
                      left: 16,
                      right: 16,
                    ),
                    color: Colors.teal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColors.enableColor,
                              width: 2,
                            ),
                          ),
                          child: ImageHelper.loadAssetImage(
                            "assets/images/ic_avatar.jpg",
                            width: 50,
                            height: 50,
                            radius: BorderRadius.circular(100),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.user.name?.firstname} ${state.user.name!.lastname}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              state.user.email.toString(),
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            logout(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.only(
                    top: 100.0,
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  color: Colors.teal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.enableColor, width: 2),
                        ),
                        child: ImageHelper.loadAssetImage(
                          "assets/images/ic_avatar.jpg",
                          width: 50,
                          height: 50,
                          radius: BorderRadius.circular(100),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'guess@quickmart.vn',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20.0),

            // Personal Information section
            _buildSectionTitle('Personal Information'),
            _buildListTile(
              icon: Icons.local_shipping_outlined,
              title: 'Shipping Address',
              onTap: () {
                // Navigate to shipping address page
              },
            ),
            _buildListTile(
              icon: Icons.payment_outlined,
              title: 'Payment Method',
              onTap: () {
                // Navigate to payment method page
              },
            ),
            _buildListTile(
              icon: Icons.history_outlined,
              title: 'Order History',
              onTap: () {
                Navigator.of(context).pushNamed(OrderHistoryPage.routeName);
              },
            ),

            // Support & Information section
            _buildSectionTitle('Support & Information'),
            _buildListTile(
              icon: Icons.policy_outlined,
              title: 'Privacy Policy',
              onTap: () {
                // Navigate to privacy policy page
              },
            ),
            _buildListTile(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                // Navigate to terms & conditions page
              },
            ),
            _buildListTile(
              icon: Icons.help_outline,
              title: 'FAQs',
              onTap: () {
                // Navigate to FAQs page
              },
            ),

            // Account Management section
            _buildSectionTitle('Account Management'),
            _buildListTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {
                // Navigate to change password page
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.dark_mode_outlined, color: Colors.black54),
              title: const Text("Dark Theme"),
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: AppColors.enableColor,
                  inactiveTrackColor: Colors.white70,
                  value: isDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkTheme = value;
                    });
                  },
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Reusable section title widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  // Reusable list tile for each section item
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.black54, size: 16.0),
      onTap: onTap,
    );
  }

  Future<void> logout(BuildContext context) async {
    DialogUtils.showLoadingDialog(context);

    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    await StorageUtils.remove(key: "userid");

    DialogUtils.hide(context);

    context.read<LoginBloc>().add(RemoveLogin());
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false, // Removes all previous routes
    );
  }

  @override
  bool get wantKeepAlive => true;
}
