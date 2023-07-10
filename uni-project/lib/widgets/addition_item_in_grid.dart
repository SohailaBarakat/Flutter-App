import 'package:flutter/material.dart';
import 'package:uni_project1/screens/literacy_screen.dart';
import 'package:uni_project1/screens/medical_clinics_screen.dart';

class AdditionItem extends StatefulWidget {
  const AdditionItem({Key? key}) : super(key: key);

  @override
  State<AdditionItem> createState() => _AdditionItemState();
}

class _AdditionItemState extends State<AdditionItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Literacy.routeName);
        },
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.7,
                width: constraints.maxWidth * 0.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  color: Color.fromARGB(255, 205, 223, 246),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Center(
                          child: Container(
                            child: Icon(
                              Icons.perm_identity,
                              color: Theme.of(context).primaryColor,
                              size: constraints.maxHeight * 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              Container(
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth * 0.8,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "محو الامية",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
