PGraphics cover;
color colors[] = {
  #0988f0,
  #ff573b,
  #ffa50b,
  #4d4d4d,
  #adb2b5,
  #d9d9d9,
  #202020
};

int shapesHeight = 10;
int shapesWidth = 10;

float t;

ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();

void settings() {
  size(int(595*1.5), int(842*1.5));
  noiseSeed(1);
  randomSeed(1);
}

void setup() {
  cover = createGraphics(595, 842);
  frameRate(30); // Set a reasonable frame rate

  //////////RECTANGLES
                float y = 0;
                while (y < cover.height) {
                    float x = 0;
                    float currentHeight = floor(random(1, 20)) * 5;
                    while (x < cover.width) {
                    float currentWidth = floor(random(1, 20)) * 20;
                    color fillColor;
                    if ((int(x / currentWidth) + int(y / currentHeight)) % 2 == 0) {
                        fillColor = colors[int(random(colors.length - 1))]; // Random color
                    } else {
                        fillColor = colors[colors.length - 1]; // Last color in the array
                    }
                    rectangles.add(new Rectangle(x, y, currentWidth-1, currentHeight-1, fillColor));
                    x += currentWidth;
                    }
                    y += currentHeight;
                }
}

void draw() {
    t++;
  cover.beginDraw();
  cover.background(color(#202020));
  cover.noStroke();
  //cover.rectMode(CENTER);

  for (int i = 0; i < rectangles.size(); i++) {
    rectangles.get(i).display();

  }

  cover.endDraw();

  image(cover, 0, 0, width, height);

  // Comment out or remove this line to enable animation
   //noLoop();
}






class Rectangle {
  float x, y, w, h, newWidth, radius;
  color fillColor;

PVector scale, scaleVelocity;

  Rectangle(float x, float y, float _width, float _height, color fillColor) {
    this.x = x;
    this.y = y;
    this.w = _width;
    this.h = _height;
    this.fillColor = fillColor;
    this.newWidth = 0;

  }

  void display() {
    this.newWidth = map(noise(x * 0.1, y * 0.1+t*0.05), 0, 1, this.w-10, this.w+10);
    
    cover.fill(fillColor);
    cover.rect(x, y, this.w, this.h, 20);
  }
}
