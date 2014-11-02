class ball3d{
  
  final float rad = 10; //radius
  final float travelRate = 0.05;//travel rate, thing is collapsed to it
  
  float u,v;
  pts ptset = PtQ;
  
  public ball3d(){
    u=v=0.5;
  }
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
