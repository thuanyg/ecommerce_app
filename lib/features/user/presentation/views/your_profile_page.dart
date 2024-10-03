import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourProfilePage extends StatelessWidget {
  const YourProfilePage({super.key});

  static String routeName = "/YourProfilePage";

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      String id = await StorageUtils.getValue(key: "userid") ?? "";

      // Now trigger the BLoC event
      BlocProvider.of<PersonalBloc>(context).add(PersonalLoadInformation(id));
    });
    return Scaffold(
      floatingActionButton: Padding(
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 28),
                  buildInputField(
                    label: "Name",
                    controller:
                        TextEditingController(text: state.user.name?.firstname),
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Username",
                    controller:
                        TextEditingController(text: state.user.username),
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Email",
                    controller: TextEditingController(text: state.user.email),
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                    label: "Phone",
                    controller: TextEditingController(text: state.user.phone),
                  ),
                  const SizedBox(height: 8),
                  buildInputField(
                      label: "Address",
                      controller: TextEditingController(
                        text: state.user.address?.city,
                      )),
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
}
