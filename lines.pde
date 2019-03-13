PImage img;


void setup() {
  size(600, 600);

  img = loadImage("fish.png");
  img.resize(width, height);
  frameRate(200);
  background(255);
}


void draw() {
  boolean[][] checked = new boolean[width][height];

  float angle = random(0.001, PI);
  PVector vector = PVector.fromAngle(angle).mult(600);
  PVector middlePoint = new PVector(random(width), random(height));

  PVector point1 = middlePoint.copy();
  PVector point2 = new PVector(middlePoint.x + vector.x, middlePoint.y + vector.y);

  float slope = (point2.y - point1.y) / (point2.x - point1.x);

  int total = 0;
  int totalBrightness = 0;

  for (float i = -600; i < 600; i += 0.1) {
    float input = i;

    PVector newPoint = new PVector(middlePoint.x + input, middlePoint.y + input * slope);
    if ((newPoint.x >= 0 && newPoint.y >= 0) && (newPoint.x < width && newPoint.y < height) && !checked[(int)newPoint.x][(int)newPoint.y]) {
      checked[(int)newPoint.x][(int)newPoint.y] = true;
      total++;
      color c = img.get((int)newPoint.x, (int)newPoint.y);
      totalBrightness += (red(c) + green(c) + blue(c)) / 3;
    }
  }

  int brightness = totalBrightness / total;

  pushMatrix();
  translate(middlePoint.x, middlePoint.y);
  stroke(0, (255 - brightness) / 2);
  line(vector.x * -1, vector.y * -1, vector.x, vector.y);
  popMatrix();
}