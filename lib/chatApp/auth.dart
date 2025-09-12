import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/chatApp/LoginAndRegister.dart';

class RegisterAndLoginAuth extends StatelessWidget {
  const RegisterAndLoginAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                 final result = await LoginAndRegister.register(username: 'amitkumarverf', password: '948304lfldk');
                 debugPrint('======================result $result');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // button color
                  foregroundColor: Colors.white, // text color
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded corners
                  ),
                  elevation: 4, // shadow depth
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // button color
                  foregroundColor: Colors.white, // text color
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded corners
                  ),
                  elevation: 4, // shadow depth
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
