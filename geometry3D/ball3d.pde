class ball3d{
  
  final float rad = 10; //radius
  final float travelRate = 0.05;//travel rate, thing is collapsed to it
  final vec x_dir = V(1,0,0);
  final vec y_dir = V(0,1,0);
  final vec z_dir = V(0,0,1);
  
  float u,v;
  pts ptset = PtQ;
  
  public ball3d(){
    u=v=0.5;
  }
  
  
  
  //test code for figuring out tangents
  
  /*void roll(){
    vec i,j,k,l;//u++, v++, u--, v--
    //assuming going clockwise, viewed from above, goes up
    i=V(coon(ptset.g, u,v), coon(ptset.g, u+.01,v)); //u++
    j=V(coon(ptset.g, u,v), coon(ptset.g, u,v+.01)); //v++
    k=V(coon(ptset.g, u,v), coon(ptset.g, u-.01,v)); //u--
    l=V(coon(ptset.g, u,v), coon(ptset.g, u,v-.01)); //v--
  
    vec norm = V( N(i,j), N(k,l) ); //(i cross j) + (k cross l)
    norm.normalize(); 
  
    vec down = V(0,-1,0);
    vec temp = N(norm, down); //makes vectore perpindicular to both norm and tangent...
    vec tang = N(norm,temp); //which should make this a tangent. 
    if (tang.y < 0) tang = V(-1.0,tang); //if vector goes up, reverse
  
    //how to move? Since I don't need i,j,k,l anymore, I can reuse those!
    if (abs(tang.y) > .001) {
      i.normalize();j.normalize();
  
      //I may have to switch these out for V(1,0,0) and V(0,0,1)
  
      float iF = d(i,tang);
      float jF = d(j,tang);
  
      u = u+iF;  u = (u > 1 ? 1 : u);  u = (u < 0 ? 0 : u);
      v = v+jF;  v = (v > 1 ? 1 : v);  v = (v < 0 ? 0 : v);
      //This just locks U and V within (0,1);
    }
    //and I have my new point.
  }*/
  
  void roll(){
    //Temp variables, exploited to find the normal.
    vec i,j,k,l;//u++, v++, u--, v--
    //assuming going clockwise, viewed from above, goes up
    i=V(coons(ptset.G, u,v), coons(ptset.G, u+.01,v)); //u++
    j=V(coons(ptset.G, u,v), coons(ptset.G, u,v+.01)); //v++
    k=V(coons(ptset.G, u,v), coons(ptset.G, u-.01,v)); //u--
    l=V(coons(ptset.G, u,v), coons(ptset.G, u,v-.01)); //v--
  
    //Now to get the normal and apply it.
    vec norm = V( N(i,j), N(k,l) ); //(i cross j) + (k cross l)
    //norm.y = 0;//This is me flattening it. With the hammer of disencapsulation. Hear the WHAM?
    norm.normalize();
    norm = V(travelRate, norm);
  
    u = u+norm.x;  u = (u > 1 ? 1 : u);  u = (u < 0 ? 0 : u);
    v = v+norm.y;  v = (v > 1 ? 1 : v);  v = (v < 0 ? 0 : v);  
  }

  void draw(){
    pt ball = coons(ptset.G, u,v);
    ball.add(V(0,0,rad));              //moving up, to true center point of ball
    show(ball, rad);
  }
}
