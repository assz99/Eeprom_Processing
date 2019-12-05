import processing.serial.*;

 PFont f;
 PFont F;
Serial myPort;         
int xPos = 1;         

int xAnt = 40;        
int yAnt = height;
float razao = 1;
int shift=40;            

int grau = 0;
float inByte = 0;
int cor = 0;
void setup (){
   f = createFont("Bahnschrift",12,true);
   F = createFont("Bahnschrift",24,true);
   size(1000, 600);  
   
   myPort = new Serial(this,"COM4", 9600); 
   myPort.bufferUntil('\n'); 
    strokeWeight(2);
  // set inital background:
   background(0); 
   xPos = 40;
   xAnt = 40;         // horizontal position of the graph
   desenhaMoldura("");
}

void draw(){
     stroke(255-cor, 0, cor);   //(127, 34, 255);//(127, 34, 255);
     strokeWeight(4);
       
       if (xPos >= width)         //  go back to begining
       {
         xPos = 40;
         background(0); 
         xAnt = 40;         // horizontal position of the graph
         desenhaMoldura("");
       } else {
        // increment the horizontal position:
        //xPos++;
      }
     
       if ((inByte >= height) || (inByte < 0) || (inByte == Float.NaN))         //  go back to begining
       {
          inByte = height-yAnt;
       }
       line(xAnt, yAnt, xPos, (int)(height-inByte));
       
       println("x " + xPos);
       println("y " + (height-inByte-shift));
       println("valor " + inByte);
       
       xAnt = xPos; 
       yAnt = (int)(height-inByte);
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    print("string = " + inString + " = ");
    // convert to an int and map to the screen height:
    inByte = float(inString);
    println(inByte);
    inByte = map(inByte, 0, 253, shift, (height- shift-20));
     xPos = xPos + 2; 
  }
}

void desenhaMoldura(String inString){
        fill(0, 102, 153);
        stroke(175);                       // temperature line
        line(40,height-40,40,0);
        
        stroke(175);                          // Time line
        line(40,height-40,width,height-40);
        
        stroke(100,100,255);                          // 30 degree line
        line(40,height-194,width,height-194);
      
        stroke(100,100,255);                          // 60 degree line
        line(40,height-344,width,height-344);
      
        textFont(F);       
        fill(255);
       
        textAlign(RIGHT);
        text("Sinal Obtido do Potenciômetro",680,40); 
                
        textAlign(RIGHT);
        text("Valor",110,40);                         
       
        fill(240);
        textFont(f); 
       
        textAlign(RIGHT);                 // 100 degree
        text("255 -",40,60);
        
        textAlign(RIGHT);                // 90 degree
        text("230 -",40,110);
        
        textAlign(RIGHT);                // 80 degree
        text("204 -",40,160);
        
        textAlign(RIGHT);                 // 70 degree
        text("179 -",40,210);
        
        textAlign(RIGHT);                // 60 degree
        text("153 -",40,260);
        
        textAlign(RIGHT);               // 50 degree
        text("127 -",40,310);
        
        textAlign(RIGHT);                 // 40 degree
        text("102 -",40,360);
        
        textAlign(RIGHT);
        text("77 -",40,410);
        
        textAlign(RIGHT);
        text("51 -",40,460);
        
        textAlign(RIGHT);
        text("26 -",40,510);
        
        textAlign(RIGHT);
        text("0 -",40,560);
}
