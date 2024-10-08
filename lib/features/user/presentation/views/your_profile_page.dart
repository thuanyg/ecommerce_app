import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourProfilePage extends StatelessWidget {
  YourProfilePage({super.key});

  static String routeName = "/YourProfilePage";

  late var nameController = TextEditingController();
  late var usernameController = TextEditingController();
  late var emailController = TextEditingController();
  late var phoneController = TextEditingController();
  late var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      String id = await StorageUtils.getValue(key: "userid") ?? "";

      // Now trigger the BLoC event
      BlocProvider.of<PersonalBloc>(context).add(PersonalLoadInformation(id));
    });
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () async {
          PersonalState currentState =
              BlocProvider.of<PersonalBloc>(context).state;
          if (currentState is PersonalLoaded) {
            DialogUtils.showLoadingDialog(context);
            await updateUser(context, currentState.user);
            DialogUtils.hide(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.blueGrey,
            ),
            child: const Center(
              child: Text(
                "Update Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          "Your profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: BlocBuilder<PersonalBloc, PersonalState>(
          builder: (context, state) {
            if (state is PersonalLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PersonalError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PersonalLoaded) {
              nameController =
                  TextEditingController(text: state.user.name?.lastname);
              usernameController =
                  TextEditingController(text: state.user.username);
              phoneController = TextEditingController(text: state.user.phone);
              emailController = TextEditingController(text: state.user.email);
              addressController =
                  TextEditingController(text: state.user.address?.city);
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: ImageHelper.loadNetworkImage(
                      'https://picsum.photos/seed/picsum/200/300',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${state.user.name?.firstname} ${state.user.name?.lastname}"
                        .toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 28),
                  buildInputField(
                    label: "Name",
                    controller: nameController,
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Username",
                    controller: usernameController,
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Phone",
                    controller: phoneController,
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Address",
                    controller: addressController,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Column buildInputField(
      {required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueGrey.shade100),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> updateUser(BuildContext context, User oldUser) async {
    User newUser = User(
      id: oldUser.id,
      name: Name(
        lastname: nameController.text,
        firstname: "",
      ),
      phone: phoneController.text,
      username: usernameController.text,
      email: emailController.text,
      password: oldUser.password,
      address: Address(
        city: addressController.text,
        street: "",
        number: 0,
        zipcode: "0",
        geolocation: Geolocation(
          long: "0",
          lat: "0",
        ),
      ),
    );
    BlocProvider.of<PersonalBloc>(context).add(PersonalUpdate(newUser));
  }
}
