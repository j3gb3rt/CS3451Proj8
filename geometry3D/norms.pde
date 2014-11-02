vec showNorms(pt P, float s, float t, float e) {
  /* get surrounding points
      D
   A  S  C
      B
  */
  pt A, B, C, D;
  A = coons(PtQ.G, s-e, t);
  B = coons(PtQ.G, s, t+e);
  C = coons(PtQ.G, s+e, t);
  D = coons(PtQ.G, s, t-e);
 
  vec n1 = showN1(P, A, B, C, D, s, t, e, magenta, -40, 3);
  vec n2 = showN2(P, A, B, C, D, s, t, e, orange, -30, 4);
  vec n3 = showN3(P, A, B, C, D, s, t, e/5.0, grey, -20, 5);
  
  return n1;
}

vec showN1(pt S, pt A, pt B, pt C, pt D, float s, float t, float e, color c, int h, int w) {
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
  norm = norm.normalize();
  norm = norm.mul(h);
  show(S, norm, c, w);
  return norm;
}

vec showN2(pt S, pt A, pt B, pt C, pt D, float s, float t, float e, color c, int h, int w) {
  /* calculate vectors of surrounding points */
  vec AC, BD;
  AC = V(A, C);
  BD = V(B, D);
  
  /* calculate normal from cross products */
  vec norm = cross(AC, BD);
  norm = norm.normalize();
  norm = norm.mul(h);
  show(S, norm, c, w);
  return norm;
}

vec showN3(pt S, pt A, pt B, pt C, pt D, float s, float t, float e, color c, int h, int w) {
  A = coons(PtQ.G, s-e, t);
  B = coons(PtQ.G, s, t+e);
  C = coons(PtQ.G, s+e, t);
  D = coons(PtQ.G, s, t-e);
  vec norm = showN1(S, A, B, C, D, s, t, e, c, h, w);
  return norm;
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
 * Show a points normal
 */
void show(pt p, vec n, color c, int w) {
  stroke(c);
  fill(c);
  arrow(p, n, w);
}

