
public class ball3d{
  pts myPoints; //what surface it applies to.
  float u,v; //Location data, first assumption is that 0 < foo < 1; may have to include scaling variables
  float y;//NOT 0 < foo < 1; represents the bottom point of the ball - 
  final float rad = 10; //radius of the drawn ball

  boolean deciding;
  int locX, locY;
  //where I AM 
  int tarX, tarY;
  //where I want to be
  float traveling = 0.0;
  final float travelRate = 0.05;


  public ball3d(){
    //Something missing.
    myPoints = PtQ;//hardcoded for now; will worry about later
    u = 0.5; v = 0.5;
    y = coons(this.myPoints.G, 0.5, 0.5).y;
    //I don't think I need stuff up here, but I'm not sure.
    deciding = true;
    locX = locY = tarX = tarY = sampleSegments/2; //(sampleSegments)/2;
    traveling = 0.0;
    
  }
  
  void draw(){/*
    fill(black);
    pt where = coons(this.P.G, this.u, this.v);
    pushMatrix();
    where.y += rad;
    sphere(rad);
    popMatrix();
    //*/
    pt ball = P(samplePoints[locX][locY]);        //initial point
    vec toGoal = V(samplePoints[locX][locY], samplePoints[tarX][tarY]);  //movement vector - here to there
    toGoal = V(traveling, toGoal);            //scaling vector via progress
    ball.add(toGoal);              //merging to find ball contact point on map
    ball.add(V(0,0,rad));              //moving up, to true center point of ball
    show(ball, rad);
  }

void roll(){ //rolling on the surface //HAVE TO REWRITE TO TREAT Z AS UP!
    if (deciding) {
      float bestY = samplePoints[locX][locY].y;
      for (int i = greater(locY - 1, 0); i <= lesser(locY + 1, sampleSegments-1); i++){//Keeps it in the array
        for (int j = greater(locX - 1,0); j <= lesser(locX + 1, sampleSegments-1); j++){//ditto
          if (samplePoints[i][j].z < bestY) {  //(targeted y of (i,j) < bestY):  
            tarX = i;
            tarY = j;
            bestY = samplePoints[i][j].z;
          }
        }
      }
      if (tarX == locX && tarY == locY) {
        traveling = travelRate;
        deciding = true;
      } else {
        deciding = false;
        traveling = travelRate;
      }
  } else {      //moving to somewhere else
    traveling += travelRate;
    if (traveling >= 1){    //reached my goal
      deciding = true;
      locX = tarX;
      locY = tarY;
      traveling = 0;
      }
    }
  }
}

int greater(int a, int b){ return (a>b ? a:b ); }
int lesser (int a, int b){ return (a<b ? a:b ); }

//Notes: 
