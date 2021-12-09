final int N = 128;
final int iter = 16;
final int SCALE = 5;
float t = 0;

Fluid fluid;

void settings() {
  size(N*SCALE, N*SCALE);
}

void setup() {
 fluid = new Fluid(0.2, 0, 0);
 
}

void mouseDragged() {
  //fluid.AddDensity(mouseX/SCALE, mouseY/SCALE, 100);
  float amtX = mouseX - pmouseX;
  float amtY = mouseY - pmouseY;
  fluid.AddDensity(mouseX/SCALE, mouseY/SCALE, 500);
  fluid.AddVelocity(mouseX/SCALE, mouseY/SCALE, amtX, amtY);
}

void draw() {
   background(0);
   int cx = int(0.5*width/SCALE);
   int cy = int(0.5*width/SCALE);
   for (int i = -1; i <= 1; i++){
     for (int j = -1; j <= 1; j++){
       fluid.AddDensity(cx+i, cy+j, random(500, 600));
     }
   }
   float angle = noise(t) * TWO_PI * 2;
   PVector v = PVector.fromAngle(angle);
   v.mult(0.1);
   t += 0.01;
   
   fluid.AddVelocity(cx, cy, v.x, v.y);
   fluid.step();
   fluid.renderD();
   fluid.renderV();
   fluid.fadeD();
}
