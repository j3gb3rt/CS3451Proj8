// ************************************ IMAGES & VIDEO 
int pictureCounter=0, frameCounter=0;
Boolean filming=false, change=false;
PImage myFace; // picture of author's face, should be: data/pic.jpg in sketch folder
void snapPicture() {saveFrame("PICTURES/P"+nf(pictureCounter++,3)+".jpg"); }

// *************************************** SAMPLE SIZE
int sampleSegments = 4;
float sampleSegmentSize = 1.0f / sampleSegments;
pt[][] samplePoints;
vec[][] normals;



// ******************************************COLORS 
color black=#000000, white=#FFFFFF, // set more colors using Menu >  Tools > Color Selector
   red=#FF0000, green=#00FF01, blue=#0300FF, yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB,
   grey=#818181, orange=#FFA600, brown=#B46005, metal=#B5CCDE, dgreen=#157901;
void pen(color c, float w) {stroke(c); strokeWeight(w);}

// ******************************** TEXT , TITLE, and USER's GUIDE
Boolean scribeText=true; // toggle for displaying of help text
void scribe(String S, float x, float y) {fill(0); text(S,x,y); noFill();} // writes on screen at (x,y) with current fill color
void scribeHeader(String S, int i) {fill(0); text(S,10,20+i*20); noFill();} // writes black at line i
void scribeHeaderRight(String S) {fill(0); text(S,width-7.5*S.length(),20); noFill();} // writes black on screen top, right-aligned
void scribeHeaderRight(String S1, String S2, String S3, String S4) {
  fill(0); 
  text(S1,width-7.5*S1.length(),20);
  text(S2,width-7.5*S2.length(),30);
  text(S3,width-7.5*S3.length(),40);
  text(S4,width-7.5*S4.length(),50);
  noFill();
} // writes black on screen top, right-aligned
void scribeFooter(String S, int i) {fill(0); text(S,10,height-10-i*20); noFill();} // writes black on screen at line i from bottom
void scribeAtMouse(String S) {fill(0); text(S,mouseX,mouseY); noFill();} // writes on screen near mouse
void scribeMouseCoordinates() {fill(black); text("("+mouseX+","+mouseY+")",mouseX+7,mouseY+25); noFill();}

// **************************** FILE SELECTION FOR SAVING AND LOADING MODELS 
//String fileName="data/points";

//String path="data/pts"; 
//void saveToFile(File selection) {
//  if (selection == null) println("Window was closed or the user hit cancel.");
//  else path=selection.getAbsolutePath();
//  println("    save path = "+path);
//  }
//
//void readFromFile(File selection) {
//  if (selection == null) println("Window was closed or the user hit cancel or file not found.");
//  else path=selection.getAbsolutePath();
//  println("    read path = "+path);
//  }
//
//
//void fileSelected(File selection) {
//  if (selection == null) println("Window was closed or the user hit cancel.");
//  else {
//    fileName = selection.getAbsolutePath();
//    println("User selected " + fileName);
//    }
//  }
//

