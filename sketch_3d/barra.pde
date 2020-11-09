class barra {
  PShape base;
  PShape orificio1, orificio2;


  float [][] vertex=new float[8][3];
  float l, r, angle;
  float t;
  float cx=0;
  float cy=0;
  float cz=0;

  float x=0;
  float y=0;
  float z=0;
  float offset=0;

  color cLinea;

  barra(float l, float r, float t, float angle, color cLinea) {
    this.l=l;
    this.r=r;
    this.t=t;
    this.angle=angle;
    this.cLinea=cLinea;
    vertices();
  }

  barra(float l, float r, float t, float angle, color cLinea, barra conexion, float offset) {
    this.l=l;
    this.r=r;
    this.t=t;
    this.angle=angle;
    this.cx=conexion.x;
    this.cy=conexion.y;
    this.cz=conexion.z;
    this.offset=offset;
    this.cLinea=cLinea;
    vertices();
  }
  barra(float l, float r, float t, float angle, color cLinea, barra conexion) {
    this.l=l;
    this.r=r;
    this.t=t;
    this.angle=angle;
    this.cx=conexion.x;
    this.cy=conexion.y;
    this.cz=conexion.z;
    this.cLinea=cLinea;
    vertices();
  }

  void show() {
    noFill();
    stroke(cLinea);
    vertices();
    shape(base);
    shape(orificio1);
    shape(orificio2);
  }

  void show(barra conexion) {
    noFill();
    stroke(cLinea);
    cx=conexion.x;
    cy=conexion.y;
    cz=conexion.z+offset;
    vertices();
    shape(base);
    shape(orificio1);
    shape(orificio2);
  }

  void rotation() {
    angle-=0.05;
    if (angle<-TWO_PI) {
      angle=0;
    }
  }

  void vertices() {

    x=cx+l*cos(angle);
    y=cy+l*sin(angle);
    z=cz;
    //vertices
    //1
    vertex[0][0]=cx+r*cos(angle+PI/2);
    vertex[0][1]=cy+r*sin(angle+PI/2);
    vertex[0][2]=cz;
    //2
    vertex[1][0]=x+r*cos(angle+PI/2);
    vertex[1][1]=y+r*sin(angle+PI/2);
    vertex[1][2]=z;
    //3
    vertex[2][0]=x+r*cos(angle-PI/2);
    vertex[2][1]=y+r*sin(angle-PI/2);
    vertex[2][2]=z;
    //4
    vertex[3][0]=cx+r*cos(angle-PI/2);
    vertex[3][1]=cy+r*sin(angle-PI/2);
    vertex[3][2]=cz;

    //base
    PShape temp;
    temp=createShape();
    temp.beginShape();
    for (int i=0; i<4; i++) {
      temp.vertex(vertex[i][0], vertex[i][1], vertex[i][2]);
    }    
    temp.endShape(CLOSE);
    base=extrusion(temp, t);   

    //orificios
    temp=createShape();
    temp.beginShape();
    polygon(cx, cy, cz, r, 10, temp, this);
    temp.endShape(CLOSE);
    orificio1=extrusion(temp, t);

    temp=createShape();
    temp.beginShape();
    polygon(x, y, z, r, 10, temp, this);
    temp.endShape(CLOSE);
    orificio2=extrusion(temp, t);
  }

  PShape extrusion(PShape baseExtrusion, float extrudeT) {
    PShape parte=new PShape();
    PVector[] v=new PVector[0];
    for (int i=0; i<baseExtrusion.getVertexCount(); i++) {
      v=(PVector[])append(v, baseExtrusion.getVertex(i));
    }
    parte=createShape();
    parte.beginShape();
    for (int i=0; i<baseExtrusion.getVertexCount(); i++) {
      if (i+1<baseExtrusion.getVertexCount()) {
        parte.vertex(v[i+1].x, v[i+1].y, v[i+1].z);
        parte.vertex(v[i+1].x, v[i+1].y, v[i+1].z+extrudeT);
        parte.vertex(v[i].x, v[i].y, v[i].z+extrudeT);
        parte.vertex(v[i].x, v[i].y, v[i].z);
        parte.vertex(v[i+1].x, v[i+1].y, v[i+1].z);
      } else {
        parte.vertex(v[0].x, v[0].y, v[0].z);
        parte.vertex(v[0].x, v[0].y, v[0].z+extrudeT);
        parte.vertex(v[i].x, v[i].y, v[i].z+extrudeT);
      }
    }
    parte.endShape();
    return parte;
  }
}
