
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restobadge/services/AuthService.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}
class LoginState extends State<Login> {
  
    bool rememberMe = false; 
    bool obscurePassword = true;
    bool isLoading = false;
    String? errorMessage;
    final TextEditingController loginController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    //Verifie  le contenu des champs dans authservice avec isLogin   
    void submit() async {
    // Vide l'erreur et afficher le loader
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final success = await Authservice.login(
      loginController.text.trim(),
      passwordController.text.trim()
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (success) {
      context.go('/');             //renvoi vers Layout !
    } else {
      setState(() {
        errorMessage = 'Login ou mot de passe incorrect';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:  Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo centré
            Center(
              child: Image.asset('assets/images/inphblogo.png', width: 80, height: 80),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Se connecter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),

            //Message d'erreur 
            if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),

            const SizedBox(height: 32),

            // Champ Login
            const Text('Login', style: TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: 'Veillez entrer votre Login',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),


            const SizedBox(height: 20),
            // Champ Mot de passe
            const Text('Mot de Passe', style: TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                hintText: 'Veillez entrer votre Mot de Passe',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() => obscurePassword = !obscurePassword);
                  },
                ),
              )
            ),


            const SizedBox(height: 12),
            // Se souvenir & Mot de passe oublié
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe, 
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false  ;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Color(0xFF4A9EE8),
                  ),
                    const Text('Se souvenir de moi', style: TextStyle(fontWeight: FontWeight.w900)),
                  ],
                ),
                TextButton(
                  onPressed: (
                    //utiliser le package go router  
                   //redirection vers la page ForgotPassword
                  ) {
                    context.go("/forgot-Password");
                  },
                  child: const Text('Mot de passe oublié ?'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bouton Valider pleine largeur
            ElevatedButton(
              onPressed: () {
                isLoading ? null : ()=> submit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 46, 51, 54),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: isLoading ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : const Text('Valider', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    ),
    );
  }
}