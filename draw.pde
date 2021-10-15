PImage save;
PImage clear;
PImage pencil;
PImage rectangle;
PImage erase;
PImage eyedropper;

boolean drawTool; // draw tool using lines from previous click to new click
boolean eraseTool; //eraser tool using white circles on click
boolean colorpickTool; //color picking tool using get()
boolean rectangleTool; //rectangle making tool
boolean eyedropperTool; //colour picking tool

float xQuadA;
float yQuadA;  //Top left corner
float xQuadB;
float yQuadB;  //Bottom right corner
//color selection box
color red;
color orange;
color yellow;
color green;
color blue;
color purple;
color selectedColor;


void setup() {
  size(1280, 720);
  background(255);
  //noStroke();
  imageMode(CENTER);
  fill(200);
  //give value to colours (the selected colour has been given a black colour just to be tested)
  red = #F51616;
  orange = #F58916;
  yellow = #F5E316;
  green = #3AE32C;
  blue = #2C30E3;
  purple = #CB27B6;
  selectedColor = #000000;

  drawTool=false;
  eraseTool=false;
  colorpickTool=false;
  rectangleTool=false;
  eyedropperTool=false;

  save = loadImage("save.png");
  clear = loadImage("clear.png");
  pencil = loadImage("pencil.png");
  rectangle = loadImage("rectangle.png");
  erase = loadImage("erase.png");
  eyedropper = loadImage("eyedropper.png");
}

void draw() {
  fill(0);
  //println(xQuadB," ",yQuadB); //debug
  //println(xQuadA, " ", yQuadA); //debug
  //rect(0, 120, 100, 100); //debug
  //tools
  fill(200);
  rect(0, 0, 1280, 120);
  image(save, 20, 20, 20, 20);
  image(clear, 60, 20, 20, 20);
  image(pencil, 200, 60, 30, 30);
  image(rectangle, 150, 60, 30, 30);
  image(erase, 250, 60, 30, 30);
  image(eyedropper, 300, 60, 30, 30);
  //colours selection
  rectMode(CENTER);
  fill(red);
  rect(400, 50, 20, 20);
  fill(orange);
  rect(425, 50, 20, 20);
  fill(yellow);
  rect(450, 50, 20, 20);
  fill(green);
  rect(400, 75, 20, 20);
  fill(blue);
  rect(425, 75, 20, 20);
  fill(purple);
  rect(450, 75, 20, 20);
  rectMode(CORNER);
}

void mouseClicked() {
  if (dist(mouseX, mouseY, 20, 20)<=10) {  //check save button
    save("draw.jpg");
    println("saved"); //debug
  } else if (dist(mouseX, mouseY, 60, 20)<=10) {  //check clear button
    fill(255);
    rect(0, 120, 1280, 600);
    println("clear"); //debug
  } else if (dist(mouseX, mouseY, 150, 60)<=15) {  //check rectangle button and set boolean to true
    eyedropperTool=false;
    rectangleTool = true;
    drawTool = false;
    eraseTool = false;
    println("rectangleTool = ", rectangleTool); //debug
  } else if (dist(mouseX, mouseY, 200, 60)<=15) {  //check pencil button and set boolean to true
    drawTool = true;
    rectangleTool = false;
    eraseTool = false;
    eyedropperTool=false;
    println("drawTool = ", drawTool); //debug
  } else if (dist(mouseX, mouseY, 250, 60)<=15) {  //check erase button and set boolean to true
    drawTool=false;
    rectangleTool = false;
    eraseTool = true;
    eyedropperTool=false;
    println("eraseTool = ", eraseTool); //debug
  } else if (dist(mouseX, mouseY, 300, 60)<=15) {  //check eyedropper button and set boolean to true
    eyedropperTool=true;
    drawTool=false;
    rectangleTool = false;
    eraseTool = false;
    println("eyedropperTool = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 400, 50)<=10) {  //check red colour and set give to selectedColor
    selectedColor = red;
    println("selectedColor = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 425, 50)<=10) {  //check orange colour and set give to selectedColor
    selectedColor = orange;
    println("selectedColor = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 450, 50)<=10) {  //check yellow colour and set give to selectedColor
    selectedColor = yellow;
    println("selectedColor = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 400, 75)<=10) {  //check green colour and set give to selectedColor
    selectedColor = green;
    println("selectedColor = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 425, 75)<=10) {  //check blue colour and set give to selectedColor
    selectedColor = blue;
    println("selectedColor = ", hex(selectedColor)); //debug
  } else if (dist(mouseX, mouseY, 450, 75)<=10) {  //check purple colour and set give to selectedColor
    selectedColor = purple;
    println("selectedColor = ", hex(selectedColor)); //debug
  }

  if (rectangleTool==true&&mouseY>120) {
    xQuadA = mouseX;
    yQuadA = mouseY;
  }

  if (eyedropperTool==true&&mouseY>120) {
    selectedColor = get(mouseX, mouseY);
  }
}

void mouseDragged() {
  if (rectangleTool==true&&mouseY>120) {
    xQuadB = mouseX;
    yQuadB = mouseY;
    //fill(255);
    //rect(0, 120, 1280, 600);
    fill(selectedColor);
    quad(xQuadA, yQuadA, xQuadB, yQuadA, xQuadB, yQuadB, xQuadA, yQuadB);
  }
  if (drawTool==true&&mouseY>120) {
    stroke(selectedColor);
    line(pmouseX, pmouseY, mouseX, mouseY);
    stroke(0);
  }
  if (eraseTool==true&&mouseY>120) {
    stroke(255);
    fill(255);
    circle(mouseX, mouseY, 50);
    fill(0);
    stroke(0);
  }
  //if (mouseDragged()){
  //rectangleTool = false;
  //}
}
//println(mouseX," ",mouseY," ",dist(mouseX, 60, mouseY, 20)); //debug(specific)
