/******** Editor of an Animated Coons Patch

Implementation steps:
**<01 Manual control of (u,v) parameters. 
**<02 Draw 4 boundary curves CT(u), CB(u), SL(v), CR(v) using proportional Neville
**<03 Compute and show Coons point C(u,v)
**<04 Display quads filed one-by-one for the animated Coons patch
**<05 Compute and show normal at C(u,v) and a ball ON the patch

*/
//**<01: mouseMoved; 'v', draw: uvShow()
float u=0, v=0; 
void uvShow() { 
  fill(red);
  if(keyPressed && key=='v')  text("u="+u+", v="+v,10,30);
  noStroke(); fill(blue); ellipse(u*width,v*height,5,5); 
  }
/*
0 1 2 3 
11    4
10    5
9 8 7 6
*/
pt coons(pt[] P, float s, float t) {
  pt Lst = L( L(P[0],s,P[3]), t, L(P[9],s,P[6]) ) ;
  pt Lt = L( N( 0,P[0], 1./3,P[1],  2./3,P[2],  1,P[3], s) ,t, N(0,P[9], 1./3,P[8], 2./3,P[7], 1,P[6], s) ) ;
  pt Ls = L( N( 0,P[0], 1./3,P[11], 2./3,P[10], 1,P[9], t) ,s, N(0,P[3], 1./3,P[4], 2./3,P[5] ,1,P[6], t) ) ;
  return P(Ls,V(Lst,Lt));
  }
pt B(pt A, pt B, pt C, float s) {return L(L(A,s,B),s,L(B,s,C)); } 
pt B(pt A, pt B, pt C, pt D, float s) {return L(B(A,B,C,s),s,B(B,C,D,s)); } 
pt B(pt A, pt B, pt C, pt D, pt E, float s) {return L(B(A,B,C,D,s),s,B(B,C,D,E,s)); } 
pt N(float a, pt A, float b, pt B, float t) {return L(A,(t-a)/(b-a),B);}
pt N(float a, pt A, float b, pt B, float c, pt C, float t) {return N(a,N(a,A,b,B,t),c,N(b,B,c,C,t),t);}
pt N(float a, pt A, float b, pt B, float c, pt C, float d, pt D, float t) {return N(a,N(a,A,b,B,c,C,t),d,N(b,B,c,C,d,D,t),t);}
pt N(float a, pt A, float b, pt B, float c, pt C, float d, pt D, float e, pt E, float t) {return N(a,N(a,A,b,B,c,C,d,D,t),e,N(b,B,c,C,d,D,e,E,t),t);}

void drawBorders(pt[] P){
  float e=0.01;
  beginShape(); for(float t=0; t<1.001; t+=e) v(coons(P,0,t)); endShape();
  beginShape(); for(float t=0; t<1.001; t+=e) v(coons(P,1,t)); endShape();
  beginShape(); for(float t=0; t<1.001; t+=e) v(coons(P,t,0)); endShape();
  beginShape(); for(float t=0; t<1.001; t+=e) v(coons(P,t,1)); endShape();
  }

void drawGrid(pt[] P, float e, boolean mode2){
  samplePoints = new pt[sampleSegments][sampleSegments];
  normals = new vec[sampleSegments][sampleSegments];
  int sampleRow = 0;
  int sampleColumn = 0;
  pt pt1;
  pt pt2;
  pt pt3;
  pt pt4;
  
  for(float s=0; s<1.001-e; s+=e) {
    sampleRow = 0;
    for(float t=0; t<1.001-e; t+=e) {
      pt1 = coons(P,s,t);
      pt2 = coons(P,s,t+e);
      pt3 = coons(P,s+e,t+e);
      pt4 = coons(P,s+e,t);
      samplePoints[sampleRow][sampleColumn] = coons(P,s+(e/2), t+(e/2));

      if(!mode2){
      beginShape(); 
        v(pt1);
        v(pt2);
        v(pt3); 
        v(pt4);
      endShape(CLOSE);
      }
      // draw normals
  
      vec norm = showNorms(samplePoints[sampleRow][sampleColumn], s+(e/2), t+(e/2), e/2);
      normals[sampleRow][sampleColumn] = norm;
      noFill(); stroke(blue); strokeWeight(2);
      
      
      sampleRow++;
    }
    sampleColumn++;
  }
}
  
void shadeSurface(pt[] P, float e){ 
  for(float s=0; s<1.001-e; s+=e) for(float t=0; t<1.001-e; t+=e) 
  {beginShape(); v(coons(P,s,t)); v(coons(P,s+e,t)); v(coons(P,s+e,t+e)); v(coons(P,s,t+e)); endShape(CLOSE);}
  }
 

 void shadeSurfaceTextured(pt[] P, float e){
   fill(white); 
    for(float s=0; s<1.001-e; s+=e) for(float t=0; t<1.001-e; t+=e) 
  {beginShape(); texture(myFace); vTextured(coons(P,s,t),s,t); vTextured(coons(P,s+e,t),s+e,t);vTextured(coons(P,s+e,t+e),s+e,t+e);vTextured(coons(P,s,t+e),s,t+e); endShape(CLOSE);}
  }
 
  
  void shadeSurfaceGouraud(pt[] P, float e){ 
    int col=0; 
     for(float s=0; s<1.001-e; s+=e){
       int row=0;
        for(float t=0; t<1.001-e; t+=e) {
          vec v=normals[row][col];
          float nx=v.x; float ny=v.y; float nz=v.z; 
          beginShape();normal(nx,ny,nz); v(coons(P,s,t)); v(coons(P,s+e,t)); v(coons(P,s+e,t+e)); v(coons(P,s,t+e)); endShape(CLOSE);//need to change to normal
          row++;
       }
      col++;
     }
  }

  
  
