import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
//Modifier Les éléments diférents avant de faire les constantes et d'importer le reste et tout regrouper dans le main
class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => DashbordState();
}

class DashbordState extends State<Dashbord> {
  //Afficher les fénêtres contextuelles 
  bool isMenuActive = false;
  bool isPersonActive = false;
  bool isSearchActive = false;
  bool isSettingsActive = false;
  bool isAvatarActive = false;

  //expensionTile
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A9EE8),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/inphblogo.png',
                    height: 40,
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: Icon(Icons.menu_rounded, size: 15),
                    onPressed: () {
                      setState(() {
                        isMenuActive = !isMenuActive;
                      });
                    },
                    color: Colors.white,
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    icon: Icon(Icons.person, size: 15),
                    onPressed: () {
                      setState(() {
                        isPersonActive = !isPersonActive;
                      });
                    },
                    color: Colors.white,
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        leadingWidth: 800,
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 15),
            onPressed: () {
              setState(() {
                isSearchActive = !isSearchActive;
              });
            },
            color: Colors.white,
            splashColor: Colors.grey,
            highlightColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.settings, size: 15),
            onPressed: () {
              setState(() {
                isSettingsActive = !isSettingsActive;
              });
            },
            color: Colors.white,
            splashColor: Colors.grey,
            highlightColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                isAvatarActive = !isAvatarActive;
              });
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(""),
              radius: 20,
              onBackgroundImageError: (exception, stackTrace) {
                Icon(Icons.broken_image_sharp);
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.speed_sharp),
                      color: Colors.grey,
                      splashColor: Color(0xFF4A9EE8),
                      highlightColor: Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      color: Colors.grey,
                      splashColor: Color(0xFF4A9EE8),
                      highlightColor: Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.handyman_rounded),
                      color: Colors.grey,
                      splashColor: Color(0xFF4A9EE8),
                      highlightColor: Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Accueil",
                            style: TextStyle(fontSize: 40, color: Colors.grey),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "Tableau de bord",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, endIndent: 0, indent: 0),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  color: Colors.red,
                                  child: Center(
                                    child: Icon(Icons.coffee_outlined, size: 40, color: Colors.white),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: 100,
                                    width: 500,
                                    color: Colors.white70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Nombre de repas servis : Données", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 5),
                                        Text("Service en cours : Données", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.blue)),
                                        const SizedBox(height: 2),
                                        Text("Prix : Données", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Container(
                                  height: 100,
                                  width: 120,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Icon(Icons.qr_code_2, size: 40, color: Colors.white),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: 100,
                                    width: 500,
                                    color: Colors.white70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        OutlinedButton(
                                          style: ButtonStyle(
                                          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                                              (states){
                                                if (states.contains(WidgetState.pressed)) {
                                                  return Colors.white;
                                                }
                                                return Color(0xFF4A9EE8);
                                              }
                                            ),
                                            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                              (states){
                                                if (states.contains(WidgetState.pressed)) {
                                                  return Color(0xFF4A9EE8);
                                                }
                                                return Colors.transparent;
                                              }
                                            ),
                                            side:  WidgetStateProperty.all(
                                              BorderSide(
                                                color: Color(0xFF4A9EE8), 
                                                width: 1.5
                                              ),
                                            ),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                            )
                                          ),
                                          
                                          onPressed: (){
                                            //Retournez le scanner avec goRouter 
                                            context.go("/scanner") ;
                                          }, 
                                          child: Text("Lecture")
                                        ),
                                        const SizedBox(height: 5),
                                        Text("Cliquez sur le bouton pour lire le code QR", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 11,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ExpansionTile(
                      initiallyExpanded: true,
                      tilePadding: EdgeInsets.zero,
                      // Appliquer un padding seulement aux enfants pour la lisibilité
                      childrenPadding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                      // Supprimer les bordures de la tuile
                      shape: const RoundedRectangleBorder(side: BorderSide.none),
                      collapsedShape:
                      const RoundedRectangleBorder(side: BorderSide.none),
                      title: Text("Entrez votre Code Pin ou le Token de Validation",style: TextStyle(fontSize: 15),),
                      trailing: Icon(
                        isExpanded ? Icons.remove : Icons.add, 
                        color: Colors.grey
                      ),
                      onExpansionChanged: (value) {
                        setState(() {
                          isExpanded = value;
                        });
                      },
                      children: [
                        ListTile(title: Text("Code Pin ou le Token de Validation *")),
                        const SizedBox(height: 3,),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          inputFormatters:[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          //Ajouter les contraintes et le conroller pour le récupérer 
                          decoration: InputDecoration(
                            focusColor: Color(0xFF4A9EE8),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(Colors.white),
                              backgroundColor:WidgetStatePropertyAll(Color(0xFF4A9EE8))  ,
                              side:  WidgetStateProperty.all(
                                BorderSide(
                                  color: Color(0xFF4A9EE8), 
                                  width: 1.5
                                ),
                              ),
                              shape: WidgetStateProperty.resolveWith(
                                (states){
                                  if(states.contains(WidgetState.pressed )){
                                    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),side: BorderSide(color: Colors.blue,width: 4));
                                  }
                                  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(3));
                                }
                                
                              )
                          ),
                          onPressed: (){
                            //verifier le token verifier le contenu du textField recupérer valider actualiser le compteur de repas servis   
                          }, 
                          child: Text("Valider")
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 11,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(alignment: AlignmentGeometry.topStart,child: Text("Les 10 dernières personnes enrégistrées"),),
                            //Ramener la liste ou un centrer avec le text
                            Center(
                              child: Text("Aucun étudiant trouvé",style: TextStyle(color: Colors.grey,fontSize: 15),),
                            )
                          ],
                        ),
                      ) 
                  ),
                ),
                
                //suite 
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Row(
        
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("© 2023 - 2026, Direction des Sytèmes d'Informations (DSI)",style: TextStyle(color: Colors.grey,fontSize: 12),)
        ],
      ),
    );
  }
}