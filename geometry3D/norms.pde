void showNorms(pt[][] samplePoints, float e) {
  /*
      D
   A  S  C
      B
   */
  showN1(samplePoints);
  showN2(samplePoints);
  showN3(samplePoints, e);
}

void showN1(pt[][] samplePoints) {
  for (int x=1; x<samplePoints.length-1; x++) {
    for (int y=1; y<samplePoints[x].length-1; y++) {
      /* get surrounding points */
      pt A, B, C, D, S;
      S = samplePoints[x][y];
      A = samplePoints[x-1][y];
      B = samplePoints[x][y+1];
      C = samplePoints[x+1][y];
      D = samplePoints[x][y-1];
      
      /* calculate vectors from S to surrounding points */
      vec SA, SB, SC, SD;
      SA = V(S, A);
      SB = V(S, B);
      SC = V(S, C);
      SD = V(S, D);
      
      /* get cross products */
      vec c1, c2, c3, c4;
      c1 = cross(SA, SB);
      c2 = cross(SB, SC);
      c3 = cross(SC, SD);
      c4 = cross(SD, SA);
      
      /* calculate normal from cross products */
      vec norm = A(A(c1, c2), A(c3, c4));
      show(norm);
    }
  }
}

void showN2(pt[][] samplePoints) {
  for (int x=1; x<samplePoints.length-1; x++) {
    for (int y=1; y<samplePoints[x].length-1; y++) {
      /* get surrounding points */
      pt A, B, C, D;
      A = samplePoints[x-1][y];
      B = samplePoints[x][y+1];
      C = samplePoints[x+1][y];
      D = samplePoints[x][y-1];
      
      /* calculate vectors of surrounding points */
      vec AC, BD;
      AC = V(A, C);
      BD = V(B, D);
      
      /* calculate normal from cross products */
      vec norm = cross(AC, BD);
      show(norm);
    }
  }
}

void showN3(pt[][] samplePoints, float e) {
  for (int x=1; x<samplePoints.length-1; x++) {
    for (int y=1; y<samplePoints[x].length-1; y++) {
      /* get surrounding points */
      pt A, B, C, D, S;
      S = samplePoints[x][y];
      A = coons(S, x-e, y);
      B = coons(S, x, y+e);
      C = coons(S, x+e, y);
      D = coons(S, x, y-e);
      
      /* calculate vectors from S to surrounding points */
      vec SA, SB, SC, SD;
      SA = V(S, A);
      SB = V(S, B);
      SC = V(S, C);
      SD = V(S, D);
      
      /* get cross products */
      vec c1, c2, c3, c4;
      c1 = cross(SA, SB);
      c2 = cross(SB, SC);
      c3 = cross(SC, SD);
      c4 = cross(SD, SA);
      
      /* calculate normal from cross products */
      vec norm = A(A(c1, c2), A(c3, c4));
      show(norm);
    }
  }
}

/**
 * Find the cross product between two vectors
 */
vec cross(vec u, vec v) {
  float x, y, z;
  x = (u.y * v.z) - (u.z * v.y);
  y = (u.z * v.x) - (u.x * v.z);
  z = (u.x * v.y) - (u.y * v.x);
  return V(x, y, z);
}

/*
 * Show a vectors normal
 */
void show(vec v) {
  
}
