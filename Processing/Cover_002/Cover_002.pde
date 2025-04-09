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

int rectCount = 20;
float rectWidth = 595/rectCount;
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

}

void draw() {
    t++;
  cover.beginDraw();
  cover.background(color(#202020));
  cover.noStroke();
  //cover.rectMode(CENTER);

  if(frameCount % 1 == 0){
    rectangles.add(new Rectangle());
  }

  for(int i = 0; i < rectangles.size(); i++){
    rectangles.get(i).updateScale();
    rectangles.get(i).updatePosition();
    rectangles.get(i).display();
    rectangles.get(i).updateLife();
  }


  cover.endDraw();

  image(cover, 0, 0, width, height);

  // Comment out or remove this line to enable animation
   //noLoop();
}


class Rectangle{
  float h;

  float lifespan = 240;
  float totalLife = lifespan;

  PVector position, velocity, acceleration;
  PVector scale, scaleVelocity, scaleAcceleration;
  float scaleForce = 0;
  float destinationForce = 0;
  float destinationNoise = 0;

  color fillColor;

  Rectangle(){
    ///POSITION
    float x = floor(random(rectCount+0.99)) * rectWidth;
    float y = random(200, cover.height);
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);

    ///SCALE
    this.scale = new PVector(rectWidth, 10);
    this.scaleVelocity = new PVector(0, 0);
    this.scaleAcceleration = new PVector(0, 0);

    ////FINAL SCALE FORCE
    this.scaleForce = random(5, 20);

    ////FINAL DESTINATION FORCE
    this.destinationForce = random(5, 20);
    

    //COLOR
    this.fillColor = colors[int(random(colors.length - 1))];

    println(this.fillColor);
  }

  void updateScale(){

   
    ////MAKE RANDOM
    PVector scaleDestination = new PVector(0, this.scaleForce);

    ///APPLY AT BEGINNING
    if(lifespan > totalLife-1){
      this.scaleAcceleration.add(scaleDestination);
    }

    this.scaleVelocity.add(this.scaleAcceleration);
    this.scale.add(this.scaleVelocity);

    this.scaleAcceleration.mult(0);
    this.scaleVelocity.limit(20);
    this.scaleVelocity.mult(0.9);

    
  }

  void updatePosition(){
    ////DESINATION
    PVector destination = new PVector(0, this.destinationForce);
    ////DESTINATION AT BIRTH
    if(lifespan > totalLife-1){
      this.velocity.add(destination);
    }
    ////DESTINATION EVERY X FRAMES
    if(lifespan%30==0 && random(1)<0.9){
      PVector destinationFrames = new PVector(0, this.destinationForce);
      this.velocity.add(destinationFrames);
    }
    //APPLY VELOCITY
    this.velocity.add(this.acceleration);
    this.position.add(this.velocity);

    this.acceleration.mult(0);
    this.velocity.limit(10);
    this.velocity.mult(0.97);
  }

  void updateLife(){
    lifespan--;
  }

  void display(){
    if(lifespan > totalLife-4){
      if(frameCount%2==0){
        cover.fill(color(#202020));
      }else{
        cover.fill(this.fillColor);
      }
    }else{
      cover.fill(this.fillColor);
    }
    
    cover.rect(this.position.x, this.position.y, this.scale.x-1, this.scale.y, 10);
  }
  
  

  }
