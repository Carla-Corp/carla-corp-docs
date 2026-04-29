import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassedCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String asset;

  const GlassedCard({
    super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width * 0.8 : 580,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xaa3d3d3d),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xffcccccc),
            width: 0.5
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  if( isMobile ) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: Colors.white, size: 26),
                        SizedBox(width: 5),
                        Text(title, style: GoogleFonts.stackSansText(
                          fontSize: 24, fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                      ],
                    ),
                  ),

                  if( isMobile) Text(description, style: GoogleFonts.poppins(
                    fontSize: 18, 
                    color: Colors.grey,
                  ), softWrap: true, textAlign: TextAlign.center),

                  if( isMobile ) SizedBox(height: 80),

                  if( isMobile) SizedBox(
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), 
                        image: DecorationImage(
                          image: AssetImage(asset),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),

                  if(! isMobile) SizedBox(
                    width: 380,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(icon, color: Colors.white, size: 26),
                              SizedBox(width: 5),
                              Text(title, style: GoogleFonts.stackSansText(
                                fontSize: 22, fontWeight: FontWeight.bold,
                                color: Colors.white
                              )),
                            ],
                          ),

                          Text(description, style: GoogleFonts.poppins(
                            fontSize: 15, 
                            color: Colors.grey,
                          ), softWrap: true),
                        ],
                      ),
                    ),
                  ),

                  if(! isMobile ) SizedBox(
                    width: 170,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), 
                        image: DecorationImage(
                          image: AssetImage(asset),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}