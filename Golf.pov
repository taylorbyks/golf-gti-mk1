// PoVRay 3.7 Scene File " Golf.pov"
// author:  Taylor Byk Schinvelski
// date:    30/09/2020
//------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
#include "shapes3.inc"
//--------------------------------------------------------------------------  right handed, y up
#declare Roda = union{
    difference {
      object{ Round_Cylinder_Tube( <0,0,0>, <0.8,0,0>, 0.85, 0.12, 1, 1 ) 
        texture { pigment{ color rgb< 1, 1, .9>*0.00 } 
          normal { bumps 0.01 scale 0.05 }
          finish { phong .20 }
        }  
      }
    
      cylinder { <-0.1,0,0>,<1,0,0>, 0.62
        texture { pigment { color Grey}  
          finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
        }         
      } 
      rotate<0,90,0>
    }
          
    intersection { 
      cylinder { <-0.1,0,0>,<1,0,0>, 0.62
        texture { Polished_Chrome finish { phong 1 }}
        rotate<0,90,0> 
      }
      union {
        //Miolo
        object { Round_Cylinder(<0,0,0>, <0,.2,0>, 0.50 , 0.05, 0)  
          texture { pigment{ color Black } finish { phong 1 }} 
          scale<.3,.3,.3>  rotate<90, 0,0> 
        } 
        //Eixo Y
        cylinder { <0,-1,0>,<0,1,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }}
        }
        //Eixo X
        cylinder { <-1,0,0>,<1,0,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }} 
        } 
        cylinder { <-1,0,0>,<1,0,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }} 
          rotate<0,0,30>
        }
        cylinder { <-1,0,0>,<1,0,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }} 
          rotate<0,0,60>
        }
        cylinder { <-1,0,0>,<1,0,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }} 
          rotate<0,0,-30>
        }
        
        cylinder { <-1,0,0>,<1,0,0>, 0.04 
          texture { Polished_Chrome finish { phong 1 }} 
          rotate<0,0,-60>
        }    
      }             
    translate<0,0,-0.1>}
}

#declare Camera_0 = camera {angle 60      // Frente
                            location  <18.0 , 2.2 , -6.0>
                            right    -x*image_width/image_height
                            look_at   <0 , 2 , 0.0>}
#declare Camera_1 = camera {angle 50   // Aerea
                            location  <18 , 6.5 , -3>
                            right    -x*image_width/image_height
                            look_at   <0.0 , .6 , 0.0>}
#declare Camera_2 = camera {angle 45 //Lateral Carro 2
                            location  <8 , 3.3 , -17>
                            right    -x*image_width/image_height
                            look_at   <7 , 2.0 , 3.0>}
#declare Camera_3 = camera {angle 65        // Lateral
                            location  <-0.001 , 2 , 5>
                            right    -x*image_width/image_height
                            look_at   <10 , 1 , 0.0>}
#declare Camera_4 = camera {angle 40   // Traseira
                            location  <-10 , 3 , 3>
                            right    -x*image_width/image_height
                            look_at   <5 , 1 , 0>}

camera{Camera_3}

// sun -------------------------------------------------------------------
light_source{<1500,2500, 2500> color White}
light_source{<-1,80, 0> color White}               
// sky ---------------------------------------------------------------------
plane{ <0,1,0>,1 hollow  
  texture{ pigment { color rgb <0.20, 0.20, 1.0> }
          finish  { ambient 0.25 diffuse 0 } 
        }      
scale 10000}
  // the clouds 
plane{ <0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.76
                        color_map { [0.5  rgbf<1.0,1.0,1.0,1.0> ]
                                    [0.6  rgb <1.0,1.0,1.0>     ]
                                    [0.65 rgb <1.5,1.5,1.5>     ]
                                    [1.0  rgb <0.5,0.5,0.5>     ] }
                       }
               finish { ambient 0.25 diffuse 0} 
              }      
       scale 500}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }
// ground ------------------------------------------------------------------
plane{<0,1,0>, 0 
       texture{Polished_Chrome
               normal { crackle 0 scale <0.35,0.25,0.25> turbulence 0 } 
               finish { reflection 0.60}}}

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
      
union{       
  //Roda TE
  union {
    Roda
    scale <.75,.75,.5> rotate<0,0,0> translate<1,1,3.05>
  } 

  //Roda TD
  union {
    Roda 
    scale <.75,.75,.5> rotate<0,180,0> translate<1,1,-.1>
  } 

  //Roda FE
  union {
    Roda 
    scale <.75,.75,.5> rotate<0,0,0> translate<5.5,1,3.05>
  }   

  //Roda FD
  union {
    Roda
    scale <.75,.75,.5> rotate<0,180,0> translate<5.5,1,-0.1>
  }
  
  //Corpo
  difference{
    union {
      union {
        union{
          object{ Round_Box(<0,.2,0>,<2.2,0.6,1>, 0.02   , 0)  
            texture { T_Chrome_3A finish { phong 1}}   
            rotate<0, 0,0> translate<0,0.1,0>
          } 
        
          difference{
            object{ 
              Round_Box(<1.06,.6,0>,<1.887,1,1>, 0.02   , 0)  
              texture { T_Chrome_3A finish { phong 1}}    
              rotate<0,0,-7.7> translate<.199,0,0> 
            }
            object{ 
              Round_Box(<1.06,.94,.3>,<1.887,1,.7>, 0.02   , 0)  
              texture { T_Chrome_3A finish { phong 1}} 
              rotate<0,0,-6> translate<.199,0,0> 
            }
          }
         object{ Round_Box(<0.2, 0.43, -.02 >,< 1.8, 0.50, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          }
          object{ Round_Box(<0.05, 0.71,-.02 >,< 2.15, 0.710000001, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          scale<1,.1,1> translate <0,.62,0>
          }
          object{ Round_Box(<0.2, 0.71, -.02 >,< 1.8, 0.710000001, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          scale<1,.1,1> translate <0,.27,0>
          }
          object{ Round_Box(<0, 0.0, -.01 >,< .000000001, .81, 1.01>, 0.02, 0 )      
              texture { pigment { color  Grey }} 
          scale<.01,1,1> translate <.8,.3,0>
          }
          object{ Round_Box(<0, 0.0, -.01 >,< .000000001, .5, 1.01>, 0.02, 0 )      
              texture { pigment { color  Grey }} 
          scale<.01,1,1> translate <1.58,.3,0>
          }
          object{ Segment_of_Torus ( 1, 0.25, 360)
            texture { pigment{ color Black} finish { phong 1}} 
            scale <.1,.1,.1>*.4 rotate<0,180,0> translate<.9,.76,1.0>
          }
          object{ Segment_of_Torus ( 1, 0.25, 360)
            texture { pigment{ color Black} finish { phong 1}} 
            scale <.1,.1,.1>*.4 rotate<0,-180,0> translate<.9,.76,-.015>
          } 
          object{ Column_N( 10,    0.7,   1.00 )
            texture{ pigment{ color Black }} 
            scale <1,1,1>*.07 rotate<90,0,0> translate<.2,.75,.94>
          } 
          union{
            object{ Round_Box(<0, 0, 0 >,< .001,.09, .12>, 0.02, 0 )      
                texture { pigment { color  Black }}
            }
            object{ Round_Box(<-0.001, .0005, .001 >,< .001,.0892, .1195>, 0.02, 0 )      
              texture { Polished_Chrome finish { phong 1 }}
            }
            object{ Round_Box(<0, 0, 0 >,< .001,.03, .1>, 0.02, 0 )      
              texture { pigment { color  Black }} 
              translate <0,.030,-0.05>
            }
            translate <1.55,.74,1.02>
          }
          
          union{
            object{ Round_Box(<0, 0, 0 >,< .001,.09, .12>, 0.02, 0 )      
              texture { pigment { color  Black }}
            }
            object{ Round_Box(<-0.001, .0005, .001 >,< .001,.0892, .1195>, 0.02, 0 )      
              texture { Polished_Chrome finish { phong 1 }}
            }
            object{ Round_Box(<0, 0, 0 >,< .001,.03, .1>, 0.02, 0 )      
              texture { pigment { color  Black }} 
              translate <0,.030,-0.05>
            }
          rotate<180,0,0> translate <1.55,.83,-.02> 
          }                   
          scale<3,3,3> 
        }
    
        difference {
          object{ Round_Box(<0,.6,0>,<1.4,1.15,1>, 0.02   , 0) 
            texture { T_Chrome_3A finish { phong 1}}   
            rotate<0,0,0> translate<0,0,0> 
          }
          
          object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
            texture { T_Chrome_3A finish { phong 1}}   
            rotate<0,0,-48> translate<.3,.50,0> 
          }
          object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
            texture { T_Chrome_3A finish { phong 1}}  
            rotate<0,0,40> translate<1.18,.47,0> 
          }  
          scale<3.54,3,3>
        }
      }
    }

    object{ Round_Box(<0,.5,.09>,<5,1.4,2.9>, 0.02   , 0) 
      texture{ pigment{ color Grey} finish { phong 1 }}   
      rotate<0,0,0> translate<0,2,0>
    }
    cylinder { <0,0,-1>,<0,0,5>,0.72 
      texture { pigment { color rgb<1,1,1>}} 
      scale <1,1,1> rotate<0,0,0> translate<1.04,1,0>
    }      
    cylinder { <0,0,-1>,<0,0,5>,0.72
      texture { pigment { color rgb<1,1,1>}}
      scale <1,1,1> rotate<0,0,0> translate<5.5,1,0>
    }
  } 
  
  //Vidros
  difference {
    union{ 
      difference {
        object{ Round_Box(<0.1,.7,0.03>,<1.4,1.14,.99>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }}  
        } 
        object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,-48> translate<.3,.50,0> 
        }
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,42> translate<1.25,.47,0>    
        }  
      }
      
      difference {
        object{ Round_Box(<0.1,.75,-.005>,<.71,1.165,1.005>, 0.09   , 0) 
         material{ texture { NBwinebottle } interior{ I_Glass }}  
        } 
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,42> translate<1.28,.47,0>    
        }  
      }
      
      difference {  
        object{ Round_Box(<.65,.75,-.005>,<1.4,1.165,1.005>, 0.09   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
        } 
        
        object{ Round_Box(<-1,1,-0.2>,<2,2,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }}
          rotate<0,0,-48> translate<.25,.50,0> 
        }    
      }
    }
    
    difference {
      object{ Round_Box(<0.1,.7,0.03>,<1.4,1.5,.98>, 0.02   , 0) 
        material{ texture { NBwinebottle } interior{ I_Glass }} 
      }
      object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,-48> translate<.3,.50,0> 
        }
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }}
          rotate<0,0,48> translate<1.25,.47,0>    
        }   
    }   
    scale<3.54,3,3> 
  }
        
  //Grade  
  union {
    box { <0.00, 0.00, -0.98>,< 1.00, 0.390, 1.98>         
      texture { 
        pigment { 
          gradient <1,1,0>
          color_map{[ 0.0 color Black ][ 0.5 color Black ][ 0.5 color Gray ][ 1.0 color Gray ]} 
          scale 0.01
        } 
        normal  { bumps 0.5 scale  0.005 }
        finish  { phong 1 reflection 0.00 }
      } 
      translate<5.600001,1.6,1> 
    } 
    //Borda Grade 
    object{ Wire_Box(<0.00, 0.00, -0.98>,< 1.00, 0.420, 1.98> , 0.02, 0)  
      texture{ pigment{ color Red}}
      translate<5.601,1.58,1> 
    }   
    //Farol Direito
    union {
      cylinder { <5,0,0>,<6.009,0,0>, 0.198
        material{ texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
          finish { diffuse 0.1 reflection 0.2  specular 0.8 roughness 0.0003 phong 1 phong_size 400}}
          interior{ ior 1.5 caustics 0.5 } 
        }
        translate<.599,1.768,.3>
      }
      cylinder { <5,0,0>,<6.002,0,0>, 0.212
        material{ texture { pigment{ color Black}}}
        translate<.599,1.768,.3>
      } 
    }
    //Farol Esquerdo
    union {
      cylinder { <5,0,0>,<6.01,0,0>, 0.198
        material{ texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
          finish { diffuse 0.1 reflection 0.2  specular 0.8 roughness 0.0003 phong 1 phong_size 400}}
          interior{ ior 1.5 caustics 0.5 } 
        }  
        translate<.599,1.768,2.7>
      } 
      cylinder { <5,0,0>,<6.002,0,0>, 0.212
        material{ texture { pigment{ color Black}}}
        translate<.599,1.768,2.7>
      }
    }
    //Logo             
    cylinder { <5,0,0>,<6.009,0,0>, 0.13
      material{ texture { pigment {color Black} }     
        interior{ ior 1.5 caustics 0.5 } 
      } 
      translate<.599,1.78,1.5>
    }
    //GTI
    object{ 
        Bevelled_Text("arial.ttf", "GTI", 10 , 35, 0.045, 1, 0.00, 0)
        texture{ pigment{ color Grey } 
            normal { bumps 0.5 scale 0.005}
            finish { specular 1 reflection 0.2}
        }
        rotate<0,90,0>
        scale<0.075,.1,.1>*1.8
        translate<6.47,1.71,1>
    } 
    translate <-0.47,0.09,0>
    scale<1.08,1,1>
  }
    
  //Parachoque
  union{
    object{ Round_Box(<0.20, 0.00, -.05 >,< .50, 0.290, 3.05>, 0.02, 0 )      
      texture { pigment { color  Black }} 
    }
    //Piscas  
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.170, 0.4>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<.005,0.06,0.1> 
    }
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.170, 0.4>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<.005,0.06,2.52> 
    }
    //Placa
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.290, 1>, 0.02, 0 )      
      texture { pigment { color  White }} 
      translate<.005,-.2,1> 
    }
    object{ 
      Bevelled_Text("arial.ttf", "Golf GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,90,0>
      scale<0.075,.1,.1>*1.5
      translate<.399,-.1,1.78>
    }
    translate<6.15,1.3,0>
  }

  union{
    object{ Round_Box(<0.20, 0.00, -.05 >,< .50, 0.290, 3.05>, 0.02, 0 )      
      texture { pigment { color  Black }}
      translate<.2,0,0> 
    }
    //Piscas  
    object{ Round_Box(<0.5, 0.00, 0 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Red }}
      translate<0,0.5,-.01> 
    }
    object{ Round_Box(<0.49, 0.00, 0 >,< .5, 0.3, 0.19>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<0,0.5,-.01> 
    }
    object{ Round_Box(<0.49, 0.00, 0 >,< .5, 0.3, 0.13>, 0.02, 0 )      
      texture { pigment { color  White }}
      translate<0,0.5,.43> 
    }
    object{ Round_Box(<0.5, 0.00, 0 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Red }}
      translate<0,.5,2.4> 
    }
    object{ Round_Box(<0.49, 0.00, .38 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<0,.5,2.4> 
    }
    object{ Round_Box(<0.49, 0.00, .38 >,< .5, 0.3, 0.51>, 0.02, 0 )      
      texture { pigment { color  White }}
      translate<0,.5,2> 
    }
    //Placa
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.290, 1>, 0.02, 0 )      
      texture { pigment { color  White }} 
      translate<.45,.41,1> 
    }
    object{ 
      Bevelled_Text("arial.ttf", "Golf GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*1.5
      translate<.56,.5,1.24>
    }
    
    object{ 
      Bevelled_Text("arial.ttf", "GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*1.3
      translate<.52,.86,2.6>
    }
    
    object{ 
      Bevelled_Text("arial.ttf", "VOLKSWAGEN", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*.8
      translate<.53,.86,0.1>
    }
    translate<-0.5,1.3,0>
  }
  translate<0,-.4,0>
}

//SEGUNDO CARRO

union{       
  //Roda TE
  union {
    Roda
    scale <.75,.75,.5> rotate<0,0,0> translate<1,1,3.05>
  } 

  //Roda TD
  union {
    Roda 
    scale <.75,.75,.5> rotate<0,180,0> translate<1,1,-.1>
  } 

  //Roda FE
  union {
    Roda 
    scale <.75,.75,.5> rotate<0,0,0> translate<5.5,1,3.05>
  }   

  //Roda FD
  union {
    Roda
    scale <.75,.75,.5> rotate<0,180,0> translate<5.5,1,-0.1>
  }
  
  //Corpo
  difference{
    union {
      union {
        union{
          object{ Round_Box(<0,.2,0>,<2.2,0.6,1>, 0.02   , 0)  
            texture{ Gold_Metal finish { phong 0.1  }scale 0.5}   
            rotate<0, 0,0> translate<0,0.1,0>
          } 
        
          difference{
            object{ 
              Round_Box(<1.06,.6,0>,<1.887,1,1>, 0.02   , 0)  
                texture{ Gold_Metal finish { phong 0.1  }scale 0.5}
                rotate<0,0,-7.7> translate<.199,0,0> 
               }
            object{ 
              Round_Box(<1.06,.94,.3>,<1.887,1,.7>, 0.02   , 0)  
              texture{ Gold_Metal finish { phong 0.1  }scale 0.5} 
              rotate<0,0,-6> translate<.199,0,0> 
            }
          }
          object{ Round_Box(<0.2, 0.43, -.02 >,< 1.8, 0.50, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          }
          object{ Round_Box(<0.05, 0.71,-.02 >,< 2.15, 0.710000001, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          scale<1,.1,1> translate <0,.62,0>
          }
          object{ Round_Box(<0.2, 0.71, -.02 >,< 1.8, 0.710000001, 1.02>, 0.02, 0 )      
              texture { pigment { color  Black }} 
          scale<1,.1,1> translate <0,.27,0>
          }
          object{ Round_Box(<0, 0.0, -.01 >,< .000000001, .81, 1.01>, 0.02, 0 )      
              texture { pigment { color  Grey }} 
          scale<.01,1,1> translate <.8,.3,0>
          }
          object{ Round_Box(<0, 0.0, -.01 >,< .000000001, .5, 1.01>, 0.02, 0 )      
              texture { pigment { color  Grey }} 
          scale<.01,1,1> translate <1.58,.3,0>
          }
          object{ Segment_of_Torus ( 1, 0.25, 360)
            texture { pigment{ color Black} finish { phong 1}} 
            scale <.1,.1,.1>*.4 rotate<0,180,0> translate<.9,.76,1.0>
          }
          object{ Segment_of_Torus ( 1, 0.25, 360)
            texture { pigment{ color Black} finish { phong 1}} 
            scale <.1,.1,.1>*.4 rotate<0,-180,0> translate<.9,.76,-.02>
          } 
          object{ Column_N( 10,    0.7,   1.00 )
            texture{ pigment{ color Black }} 
            scale <1,1,1>*.07 rotate<90,0,0> translate<.2,.75,.94>
          } 
          union{
            object{ Round_Box(<0, 0, 0 >,< .001,.09, .12>, 0.02, 0 )      
                texture { pigment { color  Black }}
            }
            object{ Round_Box(<-0.001, .0005, .001 >,< .001,.0892, .1195>, 0.02, 0 )      
              texture { Polished_Chrome finish { phong 1 }}
            }
            object{ Round_Box(<0, 0, 0 >,< .001,.03, .1>, 0.02, 0 )      
              texture { pigment { color  Black }} 
              translate <0,.030,-0.05>
            }
            translate <1.55,.74,1.02>
          }
          
          union{
            object{ Round_Box(<0, 0, 0 >,< .001,.09, .12>, 0.02, 0 )      
              texture { pigment { color  Black }}
            }
            object{ Round_Box(<-0.001, .0005, .001 >,< .001,.0892, .1195>, 0.02, 0 )      
              texture { Polished_Chrome finish { phong 1 }}
            }
            object{ Round_Box(<0, 0, 0 >,< .001,.03, .1>, 0.02, 0 )      
              texture { pigment { color  Black }} 
              translate <0,.030,-0.05>
            }
          rotate<180,0,0> translate <1.55,.83,-.02> 
          }                   
          scale<3,3,3> 
        }
    
        difference {
          object{ Round_Box(<0,.6,0>,<1.4,1.15,1>, 0.02   , 0) 
            texture{ Gold_Metal finish { phong 0.1  }scale 0.5}   
            rotate<0,0,0> translate<0,0,0> 
          }
          
          object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
            texture{ Gold_Metal finish { phong 0.1  }scale 0.5}   
            rotate<0,0,-48> translate<.3,.50,0> 
          }
          object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
            texture{ Gold_Metal finish { phong 0.1  }scale 0.5}  
            rotate<0,0,40> translate<1.18,.47,0> 
          }  
          scale<3.54,3,3>
        }
      }
    }

    object{ Round_Box(<0,.5,.09>,<5,1.4,2.9>, 0.02   , 0) 
      texture{ Gold_Metal finish { phong 0.1  }scale 0.5}    
      rotate<0,0,0> translate<0,2,0>
    }
    cylinder { <0,0,-1>,<0,0,5>,0.72 
      texture{ Gold_Metal finish { phong 0.1  }scale 0.5} 
      scale <1,1,1> rotate<0,0,0> translate<1.04,1,0>
    }      
    cylinder { <0,0,-1>,<0,0,5>,0.72
      texture{ Gold_Metal finish { phong 0.1  }scale 0.5}  
      scale <1,1,1> rotate<0,0,0> translate<5.5,1,0>
    }
  } 
  
  //Vidros
  difference {
    union{ 
      difference {
        object{ Round_Box(<0.1,.7,0.03>,<1.4,1.14,.99>, 0.02   , 0) 
          material{ texture { NBwinebottle }interior{ I_Glass }}  
        } 
        object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,-48> translate<.3,.50,0> 
        }
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,42> translate<1.25,.47,0>    
        }  
      }
      
      difference {
        object{ Round_Box(<0.1,.75,-.005>,<.71,1.165,1.005>, 0.09   , 0) 
          material{ texture { NBwinebottle }interior{ I_Glass }}  
        } 
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,42> translate<1.28,.47,0>    
        }  
      }
      
      difference {  
        object{ Round_Box(<.65,.75,-.005>,<1.4,1.165,1.005>, 0.09   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
        } 
        
        object{ Round_Box(<-1,1,-0.2>,<2,2,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,-48> translate<.25,.50,0> 
        }    
      }
    }
    
    difference {
      object{ Round_Box(<0.1,.7,0.03>,<1.4,1.5,.98>, 0.02   , 0) 
        material{ texture { NBwinebottle } interior{ I_Glass }} 
      }
      object{ Round_Box(<-1,1,-0.1>,<2,1.3,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,-48> translate<.3,.50,0> 
        }
        object{ Round_Box(<-.8,1,-0.1>,<2,1.7,1.1>, 0.02   , 0) 
          material{ texture { NBwinebottle } interior{ I_Glass }} 
          rotate<0,0,48> translate<1.25,.47,0>    
        }   
    }   
    scale<3.54,3,3> 
  }
        
  //Grade  
  union {
    box { <0.00, 0.00, -0.98>,< 1.00, 0.390, 1.98>         
      texture { 
        pigment { 
          gradient <1,1,0>
          color_map{[ 0.0 color Black ][ 0.5 color Black ][ 0.5 color Gray ][ 1.0 color Gray ]} 
          scale 0.01
        } 
        normal  { bumps 0.5 scale  0.005 }
        finish  { phong 1 reflection 0.00 }
      } 
      translate<5.600001,1.6,1> 
    } 
    //Borda Grade 
    object{ Wire_Box(<0.00, 0.00, -0.98>,< 1.00, 0.420, 1.98> , 0.02, 0)  
      texture{ pigment{ color Red}}
      translate<5.601,1.58,1> 
    }   
    //Farol Direito
    union {
      cylinder { <5,0,0>,<6.009,0,0>, 0.198
        material{ texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
          finish { diffuse 0.1 reflection 0.2  specular 0.8 roughness 0.0003 phong 1 phong_size 400}}
          interior{ ior 1.5 caustics 0.5 } 
        }
        translate<.599,1.768,.3>
      }
      cylinder { <5,0,0>,<6.002,0,0>, 0.212
        material{ texture { pigment{ color Black}}}
        translate<.599,1.768,.3>
      } 
    }
    //Farol Esquerdo
    union {
      cylinder { <5,0,0>,<6.01,0,0>, 0.198
        material{ texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
          finish { diffuse 0.1 reflection 0.2  specular 0.8 roughness 0.0003 phong 1 phong_size 400}}
          interior{ ior 1.5 caustics 0.5 } 
        }  
        translate<.599,1.768,2.7>
      } 
      cylinder { <5,0,0>,<6.002,0,0>, 0.212
        material{ texture { pigment{ color Black}}}
        translate<.599,1.768,2.7>
      }
    }
    //Logo             
    cylinder { <5,0,0>,<6.009,0,0>, 0.13
      material{ texture { pigment {color Black} }     
        interior{ ior 1.5 caustics 0.5 } 
      } 
      translate<.599,1.78,1.5>
    }
    //GTI
    object{ 
        Bevelled_Text("arial.ttf", "GTI", 10 , 35, 0.045, 1, 0.00, 0)
        texture{ pigment{ color Grey } 
            normal { bumps 0.5 scale 0.005}
            finish { specular 1 reflection 0.2}
        }
        rotate<0,90,0>
        scale<0.075,.1,.1>*1.8
        translate<6.47,1.71,1>
    } 
    translate <-0.47,0.09,0>
    scale<1.08,1,1>
  }
    
  //Parachoque
  union{
    object{ Round_Box(<0.20, 0.00, -.05 >,< .50, 0.290, 3.05>, 0.02, 0 )      
      texture { pigment { color  Black }} 
    }
    //Piscas  
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.170, 0.4>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<.005,0.06,0.1> 
    }
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.170, 0.4>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<.005,0.06,2.52> 
    }
    //Placa
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.290, 1>, 0.02, 0 )      
      texture { pigment { color  White }} 
      translate<.005,-.2,1> 
    }
    object{ 
      Bevelled_Text("arial.ttf", "Golf GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,90,0>
      scale<0.075,.1,.1>*1.5
      translate<.399,-.1,1.78>
    }
    translate<6.15,1.3,0>
  }

  union{
    object{ Round_Box(<0.20, 0.00, -.05 >,< .50, 0.290, 3.05>, 0.02, 0 )      
      texture { pigment { color  Black }}
      translate<.2,0,0> 
    }
    //Piscas  
    object{ Round_Box(<0.5, 0.00, 0 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Red }}
      translate<0,0.5,-.01> 
    }
    object{ Round_Box(<0.49, 0.00, 0 >,< .5, 0.3, 0.19>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<0,0.5,-.01> 
    }
    object{ Round_Box(<0.49, 0.00, 0 >,< .5, 0.3, 0.13>, 0.02, 0 )      
      texture { pigment { color  White }}
      translate<0,0.5,.43> 
    }
    object{ Round_Box(<0.5, 0.00, 0 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Red }}
      translate<0,.5,2.4> 
    }
    object{ Round_Box(<0.49, 0.00, .38 >,< .5, 0.3, 0.57>, 0.02, 0 )      
      texture { pigment { color  Orange }}
      translate<0,.5,2.4> 
    }
    object{ Round_Box(<0.49, 0.00, .38 >,< .5, 0.3, 0.51>, 0.02, 0 )      
      texture { pigment { color  White }}
      translate<0,.5,2> 
    }
    //Placa
    object{ Round_Box(<0.00, 0.00, 0 >,< .5, 0.290, 1>, 0.02, 0 )      
      texture { pigment { color  White }} 
      translate<.45,.41,1> 
    }
    object{ 
      Bevelled_Text("arial.ttf", "Golf GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*1.5
      translate<.56,.5,1.24>
    }
    
    object{ 
      Bevelled_Text("arial.ttf", "GTI", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*1.3
      translate<.52,.86,2.6>
    }
    
    object{ 
      Bevelled_Text("arial.ttf", "VOLKSWAGEN", 10 , 35, 0.045, 1, 0.00, 0)
      texture{ pigment{ color Black }}
      rotate<0,270,0>
      scale<0.075,.1,.1>*.8
      translate<.53,.86,0.1>
    }
    translate<-0.5,1.3,0>
  }
  translate<6,-.4,-1>    rotate<0,30,0>
}