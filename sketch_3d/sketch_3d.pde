import peasy.*;
PeasyCam cam;
barra bancada, entrada, acoplador, salida;
float l1, l2, l3, l4;
float r, t;
float a1, a2, a3, a4;
color blanco, azul, verde, rojo;


void setup() {
  size(600, 600, P3D);
  frameRate(40);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  //cam.setActive(false); 
  //cam.setRotations(0, 60/PI, 0);
  r=10;
  t=5;
  blanco = color(255);
  azul = color(0,0,255);
  verde = color(0,255,0);
  rojo = color(255,0,0);
  l1=70;
  l2=70;
  l3=70;
  l4=70;

  a1=0;
  a2=PI/2;
  a3=0;
  a4=PI/2;

  bancada=new barra(l1, r, t, a1,blanco);
  entrada=new barra(l2, r, t, a2,azul);
  acoplador=new barra(l3, r, t, a3,verde, entrada, t);
  salida=new barra(l4, r, t, a4,rojo, bancada);
}

void draw() {
  background(0);
  bancada.show();
  
  entrada.show();
  
  acoplador.show(entrada);
  
  salida.show(bancada);
  
  entrada.rotation();
}

void polygon(float x, float y, float z, float radius, int npoints, PShape figura, barra eslabon) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+eslabon.angle) * radius;
    float sy = y + sin(a+eslabon.angle) * radius;
    float sz = z;
    figura.vertex(sx, sy, sz);
  }
}
