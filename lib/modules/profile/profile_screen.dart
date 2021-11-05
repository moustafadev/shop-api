import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/componets/constants.dart';

class ProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {

        var cubitProfile = ShopCubit.get(context).userModelData;
        emailController.text = cubitProfile!.data!.email!;
        phoneController.text = cubitProfile.data!.phone!;
        nameController.text = cubitProfile.data!.name!;

        return SingleChildScrollView(
          child: Column(
            children: [
              if(states is ShopLoadingUpdateProfileStates)
                LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            color: Colors.grey,
                            boxShadow: [ BoxShadow(
                                color: Colors.grey.shade600,
                                blurRadius: 18.0
                            )]
                        ),
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage('${cubitProfile.data!.image}'),
                        ),
                      ),
                      const SizedBox(height: 25.0,),
                      Text(
                        '${cubitProfile.data!.name}',
                        style: const TextStyle(
                            fontSize: 25.0
                        ),
                      ),
                      const SizedBox(height: 30.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                            border:  InputBorder.none,
                            type: TextInputType.emailAddress,
                            label: 'Name',
                            prefix: Icons.email,
                            controller: nameController,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Name must not be is empty';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                            border:  InputBorder.none,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            controller: emailController,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Email must not be is empty';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                            border:  InputBorder.none,
                            type: TextInputType.emailAddress,
                            label: 'Phone',
                            prefix: Icons.email,
                            controller: phoneController,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Phone must not be is empty';
                              }
                              return null;
                            }
                        ),
                      ),const SizedBox(height: 15.0,),
                      Container(
                          decoration: BoxDecoration(
                              color: HexColor('CDD6DB'),
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          width: double.infinity,
                          height: 50.0,
                          child: elevatedButtonBuilder(
                              text: 'Update',
                              onPressed: () {
                                ShopCubit.get(context).getUpdateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              },
                              width: 30.0
                          )
                      ),
                      const SizedBox(height: 50.0,),
                      Container(
                          decoration: BoxDecoration(
                              color: HexColor('CDD6DB'),
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          width: double.infinity,
                          height: 50.0,
                          child: elevatedButtonBuilder(
                              text: 'Logout',
                              onPressed: () {
                                signOut(context);
                              },
                              width: 30.0
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
