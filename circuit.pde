//red p.

import java.io.File;
import java.io.IOException;

PrintWriter output;

String[] lines;

float[][] grid;
float size = 35;

float xclick;
float yclick;

int selected = 1;
String[] sel;


boolean dragging = false;
boolean del = false;

boolean load;

boolean loadmacro;

boolean savemacro;


boolean loadmacros;

boolean loadmacrob;

boolean savemacroupb;

boolean savemacroups;

boolean savemacrolowb;

boolean savemacrolows;

boolean nofile;


boolean outofbound;

boolean write = false;

boolean entered = false;

String enter;

int casex;
int casey;

int upx;
int upy;
int lowx;
int lowy;

int casew;
int caseh;

String in = "";

boolean save = false;

float messagelife;


boolean exit = false;



float xmove = 0;
float ymove = 0;


void setup(){
  
  fullScreen();
  
  frameRate(240);
  
  grid = new float[int(width/size) + 1][int(height/size) + 1];
  sel = new String[40];
  
  createstrings();
    
  textSize(15);
  
}


void draw(){
  
  background(255);
  
  textSize(15);
  
  
  fill(150);
  stroke(0);
  
  //save and quit
  rect(width - 15, 0, 15, 15);
  
  fill(150, 150, 0);
  
  //load
  rect(width - 15 * 2, 0, 15, 15);
  
  fill(150);
  
  //savemacro
  rect(width - 15 * 3, 0, 15, 15);
  
  fill(150, 150, 0);
  
  //loadmacro
  rect(width - 15 * 4, 0, 15, 15);
  
  
  fill(0, 0, 200);
  
  //zoom
  rect(width - 15, 15, 15, 10);
  rect(width - 15, 25, 15, 10);
  
  
  for(int i = int(size); i <= width + size; i += size){
    
    line(float(i), size, float(i), height + 5);
    
  }
  
  for(int j = int(size); j <= height + size; j += size){
    
    line(size, float(j), width + 5, float(j));
    
  }
  
  
  //mouse square
  fill(255, 200, 200);
  if(mouseY > size && mouseX > size){
    rect((floor(mouseX / size)) * size, (floor(mouseY / size)) * size, size, size);
  }
  
  for(int i = 0; i < width/size; i++){ 
    for(int j = 0; j < height/size; j++){
      if(grid[i][j] >= 1 && grid[i][j] <= 15){
        stroke(0);
        if(grid[i][j] == 1){
          fill(0);
        }else {
          fill((grid[i][j]*255)/15, 0, 0);
        }
        
        ellipse((float(i)) * size + size/2, (float(j)) * size + size/2, size/4, size/4);
        text(int(grid[i][j]) - 1, (float(i)) * size + size/2, (float(j)) * size + size);
        
        if(grid[i][j] == 1){
          stroke(0);
        }else {
          stroke((grid[i][j]*255)/15, 0, 0);
        }
        
        //check above
        if(j > 0){
          if((grid[i][j-1] >= 1 && grid[i][j-1] <= 15) || grid[i][j-1] == 16){
            line(float(i) * size + size/2, float(j) * size, float(i) * size + size/2, float(j) * size + size/2);
          }
        }
        
        //check bellow
        if(j < height/size - 1){
          if((grid[i][j+1] >= 1 && grid[i][j+1] <= 15) || grid[i][j+1] == 16){
            line(float(i) * size + size/2, float(j) * size + size/2, float(i) * size + size/2, float(j) * size + size);
          }
        }
        
        //check left
        if(i > 0){
          if((grid[i-1][j] >= 1 && grid[i-1][j] <= 15) || grid[i-1][j] == 16){
            line(float(i) * size, float(j) * size + size/2, float(i) * size + size/2, float(j) * size + size/2);
          }
        }
        
        //check right
        if(i < width/size - 1){
          if((grid[i+1][j] >= 1 && grid[i+1][j] <= 15) || grid[i+1][j] == 16){
            line((float(i)) * size + size/2, (float(j)) * size + size/2, float(i) * size + size, float(j) * size + size/2);
          }
        }
        
        
        
        //check inverter
        if(j > 0 && grid[i][j-1] == 19){
          if(mostpower(i, j-1) == 1){
            grid[i][j-1] = 21;
          }
        }else if(j < height/size - 1 && grid[i][j+1] == 19){
          if(mostpower(i, j+1) == 2){
            grid[i][j+1] = 20;
          }
        }else if(i > 0 && grid[i-1][j] == 19){
          if(mostpower(i-1, j) == 3){
            grid[i-1][j] = 22;
          }
        }else if(i < width/size - 1 && grid[i+1][j] == 19){
          if(mostpower(i+1, j) == 4){
            grid[i+1][j] = 23;
          }
        }
        
        
        if(mostpower(i, j) == 1){
          
          if(j - 1 > 0 && grid[i][j-1] == 25){
            grid[i][j] = 15;
          }else {
            if(i - 1 > 0 && j - 1 > 0 && grid[i-1][j] != 22 && grid[i][j-1] != 21){
              grid[i][j] = grid[i][j-1] - 1;
            }else if(i - 1 == 0){
              grid[i][j] = grid[i][j-1] - 1;
            }
          }
          
        }else if(mostpower(i, j) == 2){
          
          if(j + 1 < width/size - 1 && grid[i][j+1] == 25){
            grid[i][j] = 15;
          }else {
            if(i - 1 > 0 && j - 1 > 0 &&  grid[i-1][j] != 22 && grid[i][j-1] != 21){
              grid[i][j] = grid[i][j+1] - 1;
            }else if(i - 1 == 0){
              grid[i][j] = grid[i][j+1] - 1;
            }
          }
          
        }else if(mostpower(i, j) == 3){
          
          if(i - 1 > 0 && grid[i-1][j] == 25){
            grid[i][j] = 15;
          }else {
            if(j - 1 > 0 && grid[i-1][j] != 22 && grid[i][j-1] != 21){
              grid[i][j] = grid[i-1][j] - 1;
            }else if(i - 1 == 0){
              grid[i][j] = grid[i-1][j] - 1;
            }
          }
          
        }else if(mostpower(i, j) == 4){
          
          if(i + 1 < width/size - 1 && grid[i+1][j] == 25){
            grid[i][j] = 15;
          }else {
            if(i - 1 > 0 && j - 1 > 0 && grid[i-1][j] != 22 && grid[i][j-1] != 21){
              grid[i][j] = grid[i+1][j] - 1;
            }else if(i - 1 == 0){
              grid[i][j] = grid[i+1][j] - 1;
            }
          }
          
        }else {
          
          if(i - 1 > 0 && j - 1 > 0){
            if(grid[i-1][j] != 22 && grid[i][j-1] != 21){
              grid[i][j] = 1;
            }
          }else {
            grid[i][j] = 1;
          }
          
        }
        
        
        //check diodes
        
        //27 = diode up
        //28 = diode down
        //29 = diode right
        //30 = diode left
        
        if(j > 0 && grid[i][j-1] == 27){
          
          if(grid[i][j-2] > 1 && grid[i][j-2] <= 15){
            
            grid[i][j] = 15;
            
          }
          
        }else if(j < height/size - 1 && grid[i][j+1] == 28){
          
          if(grid[i][j+2] > 1 && grid[i][j+2] <= 15){
            
            grid[i][j] = 15;
            
          }
          
        }else if(i > 0 && grid[i-1][j] == 29){
          
          if(grid[i-2][j] > 1 && grid[i-2][j] <= 15){
            
            grid[i][j] = 15;
            
          }
          
        }else if(i < width/size - 1 && grid[i+1][j] == 30){
          
          if(grid[i+2][j] > 1 && grid[i+2][j] <= 15){
            
            grid[i][j] = 15;
            
          }
          
        }
        
        //check bridge
        
        if(j > 0 && grid[i][j-1] == 31){
          
          if(grid[i][j-2] > 1 && grid[i][j-2] <= 15 && grid[i][j-2] > grid[i][j]){
            
            grid[i][j] = grid[i][j-2] - 2;
            
          }
          
        }else if(j < height/size - 1 && grid[i][j+1] == 31){
          
          if(grid[i][j+2] > 1 && grid[i][j+2] <= 15 && grid[i][j+2] > grid[i][j]){
            
            grid[i][j] = grid[i][j+2] - 2;
            
          }
          
        }else if(i > 0 && grid[i-1][j] == 31){
          
          if(grid[i-2][j] > 1 && grid[i-2][j] <= 15 && grid[i-2][j] > grid[i][j]){
            
            grid[i][j] = grid[i-2][j] - 2;
            
          }
          
        }else if(i < width/size - 1 && grid[i+1][j] == 31){
          
          if(grid[i+2][j] > 1 && grid[i+2][j] <= 15 && grid[i+2][j] > grid[i][j]){
            
            grid[i][j] = grid[i+2][j] - 2;
            
          }
          
        }
        
        if(grid[i][j] <= 0){
              
          grid[i][j] = 1;
          
        }
        
        
      //lines for power
      }else if(grid[i][j] == 16){
        
        fill(255, 0, 0);
        stroke(255, 0, 0);
        ellipse((float(i)) * size + size/2, (float(j)) * size + size/2, size/4, size/4);
        
        //check above
        if(j > 0){
          if(grid[i][j-1] >= 1 && grid[i][j-1] <= 15){
            line(float(i) * size + size/2, float(j) * size, float(i) * size + size/2, float(j) * size + size/2);
          }
        }
        
        //check bellow
        if(j < height/size - 1){
          if(grid[i][j+1] >= 1 && grid[i][j+1] <= 15){
            line(float(i) * size + size/2, float(j) * size + size/2, float(i) * size + size/2, float(j) * size + size);
          }
        }
        
        //check left
        if(i > 0){
          if(grid[i-1][j] >= 1 && grid[i-1][j] <= 15){
            line(float(i) * size, float(j) * size + size/2, float(i) * size + size/2, float(j) * size + size/2);
          }
        }
        
        //check right
        if(i < width/size - 1){
          if(grid[i+1][j] >= 1 && grid[i+1][j] <= 15){
            line((float(i)) * size + size/2, (float(j)) * size + size/2, float(i) * size + size, float(j) * size + size/2);
          }
        }
      
      // lamps
      }else if(grid[i][j] == 17 || grid[i][j] == 18){
        
        stroke(0);
        
        if(grid[i][j] == 17){
          fill(160, 160, 160);
        }else {
          fill(250, 230, 0);
        }
        
        rect(float(i) * size, float(j) * size, size, size);
        
        if(power(i, j)){
          
          grid[i][j] = 18;
          
        }else {
          
          grid[i][j] = 17;
          
        }

      //inverters
      }else if(grid[i][j] >= 19 && grid[i][j] <= 23){
        //19 = inverter free
        
        //20 = inverter up
        //21 = inverter down
        //22 = inverter right
        //23 = inverter left
        
        //1 up
        //2 down
        //3 left
        //4 right
        
        
        if(grid[i][j] == 20){
          if(grid[i][j+1] > 1 && grid[i][j+1] <= 15){
            if(grid[i][j-1] >= 1 && grid[i][j-1] <= 15){
              grid[i][j-1] = 1;
            }
          }else {
            if(grid[i][j-1] >= 1 && grid[i][j-1] <= 15){
              grid[i][j-1] = 15;
            }
          }
        }else if(grid[i][j] == 21){
          if(grid[i][j-1] > 1 && grid[i][j-1] <= 15){
            if(grid[i][j+1] >= 1 && grid[i][j+1] <= 15){
              grid[i][j+1] = 1;
            }
          }else {
            if(grid[i][j+1] >= 1 && grid[i][j+1] <= 15){
              grid[i][j+1] = 15;
            }
          }
        }else if(grid[i][j] == 22){
          if(grid[i-1][j] > 1 && grid[i-1][j] <= 15){
            if(grid[i+1][j] >= 1 && grid[i+1][j] <= 15){
              grid[i+1][j] = 1;
            }
          }else {
            if(grid[i+1][j] >= 1 && grid[i+1][j] <= 15){
              grid[i+1][j] = 15;
            }
          }
        }else if(grid[i][j] == 23){
          if(grid[i+1][j] > 1 && grid[i+1][j] <= 15){
            if(grid[i-1][j] >= 1 && grid[i-1][j] <= 15){
              grid[i-1][j] = 1;
            }
          }else {
            if(grid[i-1][j] >= 1 && grid[i-1][j] <= 15){
              grid[i-1][j] = 15;
            }
          }
        }
        
        
        fill(100, 50, 50);
        stroke(0);
        
        rect(float(i) * size, float(j) * size, size, size);
        
        fill(200, 100, 100);
        
        if(grid[i][j] == 21){
          rect(float(i) * size, float(j) * size + size/2, size, size/2);
        }else if(grid[i][j] == 20){
          rect(float(i) * size, float(j) * size, size, size/2);
        }else if(grid[i][j] == 22){
          rect(float(i) * size + size/2, float(j) * size, size/2, size);
        }else if(grid[i][j] == 23){
          rect(float(i) * size, float(j) * size, size/2, size);
        }
        fill(0);
        stroke(0);
        
        
      //flasher
      }else if(grid[i][j] == 24 || grid[i][j] == 25){
        
        if(frameCount % 30 < 15){
          grid[i][j] = 24;
          fill(100, 0, 0);
        }else {
          grid[i][j] = 25;
          fill(255, 0, 0);
        }
        
        stroke(0);
        rect(float(i) * size, float(j) * size, size, size);
        
        //diodes
      }else if(grid[i][j] == 26 || grid[i][j] == 27 || grid[i][j] == 28 || grid[i][j] == 29 || grid[i][j] == 30){
        
        //26 = diode off
        
        //27 = diode up
        //28 = diode down
        //29 = diode right
        //30 = diode left
        
        if(grid[i][j] == 26){
          if(mostpower(i, j) == 1){
            
            grid[i][j] = 27;
            
          }else if(mostpower(i, j) == 2){
            
            grid[i][j] = 28;
            
          }else if(mostpower(i, j) == 3){
            
            grid[i][j] = 29;
            
          }else if(mostpower(i, j) == 4){
            
            grid[i][j] = 30;
            
          }
          
        }
        
        
        stroke(0);
        fill(0, 12, 116);
        
        rect(float(i) * size, float(j) * size, size, size);
        
        fill(0, 134, 234);
        
        if(grid[i][j] == 27){
          rect(float(i) * size, float(j) * size + size/2, size, size/2);
        }else if(grid[i][j] == 28){
          rect(float(i) * size, float(j) * size, size, size/2);
        }else if(grid[i][j] == 29){
          rect(float(i) * size + size/2, float(j) * size, size/2, size);
        }else if(grid[i][j] == 30){
          rect(float(i) * size, float(j) * size, size/2, size);
        }
          
      //bridge
      }else if(grid[i][j] == 31){
        
        if(power(i, j)){
          
          fill(250, 0, 0);
          
        }else {
          
          fill(110, 0, 0);
          
        }
        
        stroke(0);
        
        rect(float(i) * size, float(j) * size, size, size);
        
        if(grid[i-1][j] > 1 && grid[i-1][j] <= 15){
          
          stroke(0);
          
        }else if(grid[i-1][j] > 1 && grid[i-1][j] <= 15){
          
          stroke(0);
          
        }else {
          
          stroke(255, 0, 0);
          
        }
        
        line(float(i) * size + size/2, float(j) * size, float(i) * size + size/2, float(j) * size + size);
        
        if(grid[i-1][j] > 1 && grid[i-1][j] <= 15){
          
          stroke(0);
          
        }else if(grid[i-1][j] > 1 && grid[i-1][j] <= 15){
          
          stroke(0);
          
        }else {
          
          stroke(255, 0, 0);
          
        }
        
        line(float(i) * size, float(j) * size + size/2, float(i) * size + size, float(j) * size + size/2);

        
        
        
      //load macro
      }else if(grid[i][j] == 32){
        
        fill(0, 130, 215);
        stroke(0);
        
        rect(float(i) * size, float(j) * size, size, size);
        
      //save macro upper
      }else if(grid[i][j] == 33){
        
        fill(185, 0, 215);
        stroke(0);
        
        rect(float(i) * size, float(j) * size, size, size);
        
      //save macro lower
      }else if(grid[i][j] == 34){
        
        fill(215, 0, 130);
        stroke(0);
        
        rect(float(i) * size, float(j) * size, size, size);
        
      }
    
    }
  }
  
  fill(0);
  
  text("Xgrid: " + (floor(mouseX / size)), 0, 15);
  text("Ygrid: " + (floor(mouseY / size)), 0, 30);
  text(sel[selected - 1], textWidth("Xgrid: " + (floor(mouseX / size))) + 10, 15 + size/4);
  
  
  float dist = textWidth("Xgrid: " + (floor(mouseX / size)) + 10 + sel[selected - 1]);
  
  if(selected == 1){
    fill(0);
    stroke(0);
    
    ellipse(dist + size/2, 0 + size/2, size/4, size/4);
  }else if(selected == 16){
    fill(255, 0, 0);
    stroke(255, 0, 0);
    
    ellipse(dist + size/2, 0 + size/2, size/4, size/4);
  }else if(selected == 17){
    fill(160, 160, 160);
    stroke(0);
    
    rect(dist, 0, size, size);
  }else if(selected == 19){
    fill(100, 50, 50);
    stroke(0);
    
    rect(dist, 0, size, size);
  }else if(selected == 24){
    fill(100, 0, 0);
    stroke(0);
    
    rect(dist, 0, size, size);
  }else if(selected == 26){
    stroke(0);
    fill(0, 12, 116);
    
    rect(dist, 0, size, size);
  }else if(selected == 31){
    fill(110, 0, 0);
    stroke(0);
    
    rect(dist, 0, size, size);
    
    line(dist, 0 + size/2, dist + size, 0 + size/2);
    line(dist + size/2, 0, dist + size/2, 0 + size);
  }else if(selected == 32){
    fill(0, 130, 215);
        
    rect(dist, 0, size, size);
  }else if(selected == 33){
    fill(185, 0, 215);
    
    rect(dist, 0, size, size);
  }else if(selected == 34){
    fill(215, 0, 130);
    
    rect(dist, 0, size, size);
  }
  
  
  for(int i = 1; i <= 34; i++){
    if(i == 1){
      fill(0);
      stroke(0);
      
      ellipse(0 + size/2, size + size/2, size/4, size/4);
    }else if(i == 16){
      fill(255, 0, 0);
      stroke(255, 0, 0);
      
      ellipse(0 + size/2, size * 2 + size/2, size/4, size/4);
    }else if(i == 17){
      fill(160, 160, 160);
      stroke(0);
      
      rect(0, size * 3, size, size);
    }else if(i == 19){
      fill(100, 50, 50);
      stroke(0);
      
      rect(0, size * 4, size, size);
    }else if(i == 24){
      fill(100, 0, 0);
      stroke(0);
      
      rect(0, size * 5, size, size);
    }else if(i == 26){
      stroke(0);
      fill(0, 12, 116);
      
      rect(0, size * 6, size, size);
    }else if(i == 31){
      fill(110, 0, 0);
      stroke(0);
      
      rect(0, size * 7, size, size);
      
      line(0, size * 7 + size/2, 0 + size, size * 7 + size/2);
      line(0 + size/2, size * 7, 0 + size/2, size * 7 + size);
    }else if(i == 32){
      stroke(0);
      fill(0, 130, 215);
      
      rect(0, size * 8, size, size);
    }else if(i == 33){
      stroke(0);
      fill(185, 0, 215);
      
      rect(0, size * 9, size, size);
    }else if(i == 34){
      stroke(0);
      fill(215, 0, 130);
      
      rect(0, size * 10, size, size);
    }
  }
  
  if(mouseX < size && mouseY > size && mouseY < size * 11){
    textSize(20);
    
    stroke(0, 200, 0);
    fill(0, 200, 0);
    
    if(mouseY < size * 2){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("WIRE") + 4, 15 + 4);
      fill(0, 200, 0);
      text("WIRE", mouseX, mouseY);
    }else if(mouseY < size * 3){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("POWER") + 4, 15 + 4);
      fill(0, 200, 0);
      text("POWER", mouseX, mouseY);
    }else if(mouseY < size * 4){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("LAMP") + 4, 15 + 4);
      fill(0, 200, 0);
      text("LAMP", mouseX, mouseY);
    }else if(mouseY < size * 5){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("INVERTER") + 4, 15 + 4);
      fill(0, 200, 0);
      text("INVERTER", mouseX, mouseY);
    }else if(mouseY < size * 6){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("FLASHER") + 4, 15 + 4);
      fill(0, 200, 0);
      text("FLASHER", mouseX, mouseY);
    }else if(mouseY < size * 7){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("DIODE") + 4, 15 + 4);
      fill(0, 200, 0);
      text("DIODE", mouseX, mouseY);
    }else if(mouseY < size * 8){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("BRIDGE") + 4, 15 + 4);
      fill(0, 200, 0);
      text("BRIDGE", mouseX, mouseY);
    }else if(mouseY < size * 9){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("LOAD MACRO CORNER") + 4, 15 + 4);
      fill(0, 200, 0);
      text("LOAD MACRO CORNER", mouseX, mouseY);
    }else if(mouseY < size * 10){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("SAVE MACRO UPPER LEFT") + 4, 15 + 4);
      fill(0, 200, 0);
      text("SAVE MACRO UPPER LEFT", mouseX, mouseY);
    }else if(mouseY < size * 11){
      fill(0);
      rect(mouseX - 2, mouseY - (2 + 15), textWidth("SAVE MACRO LOWER RIGHT") + 4, 15 + 4);
      fill(0, 200, 0);
      text("SAVE MACRO LOWER RIGHT", mouseX, mouseY);
    }
    
    textSize(15);
  }
  
  stroke(0, 200, 0);
  fill(0, 200, 0);
  if(mouseX >= width - (4 * 15) && mouseY <= 15){
    if(mouseX > width - 15){
      fill(0);
      rect(mouseX - textWidth("SAVE AND QUIT") + 4, mouseY - (2 + 15) + 15*2, textWidth("SAVE AND QUIT") + 4, 15 + 4);
      fill(0, 200, 0);
      text("SAVE AND QUIT", mouseX- textWidth("SAVE AND QUIT") + 6, mouseY + 15*2);
    }else if(mouseX > width - 30){
      fill(0);
      rect(mouseX - textWidth("LOAD") + 4, mouseY - (2 + 15) + 15*2, textWidth("LOAD") + 4, 15 + 4);
      fill(0, 200, 0);
      text("LOAD", mouseX- textWidth("LOAD") + 6, mouseY + 15*2);
    }else if(mouseX > width - 45){
      fill(0);
      rect(mouseX - textWidth("SAVE MACRO") + 4, mouseY - (2 + 15) + 15*2, textWidth("SAVE MACRO") + 4, 15 + 4);
      fill(0, 200, 0);
      text("SAVE MACRO", mouseX- textWidth("SAVE MACRO") + 6, mouseY + 15*2);
    }else if(mouseX > width - 60){
      fill(0);
      rect(mouseX - textWidth("LOAD MACRO") + 4, mouseY - (2 + 15) + 15*2, textWidth("LOAD MACRO") + 4, 15 + 4);
      fill(0, 200, 0);
      text("LOAD MACRO", mouseX- textWidth("LOAD MACRO") + 6, mouseY + 15*2);
    }
  }
  
  if(mouseX >= width - 15 && mouseY > 15 && mouseY <= 35){
    if(mouseY >= 25){
      fill(0);
      rect(mouseX - textWidth("LOWER RESOLUTION") + 4, mouseY - (2 + 15) + 15*2, textWidth("LOWER RESOLUTION") + 4, 15 + 4);
      fill(0, 200, 0);
      text("LOWER RESOLUTION", mouseX- textWidth("LOWER RESOLUTION") + 4, mouseY + 15*2);
    }else {
      fill(0);
      rect(mouseX - textWidth("RAISE RESOLUTION") + 4, mouseY - (2 + 15) + 15*2, textWidth("RAISE RESOLUTION") + 4, 15 + 4);
      fill(0, 200, 0);
      text("RAISE RESOLUTION", mouseX- textWidth("RAISE RESOLUTION") + 4, mouseY + 15*2);
    }
  }
  
  
  
  if(write){
    
    fill(255);
    stroke(0);
    
    strokeWeight(3);
    
    if(textWidth(in) > textWidth("Press ENTER to save name")){
      rect(width/2 - textWidth(in)/2 - 3, height/2 - 15/2, textWidth(in) + 6, 45 + 3);
      line(width/2 - textWidth(in)/2 - 3, height/2 + 15/2, width/2 - textWidth(in)/2 + textWidth(in) + 3, height/2 + 15/2);
    }else {
      rect(width/2 - textWidth("Press ENTER to save name")/2 - 3, height/2 - 15/2, textWidth("Press ENTER to save name") + 6, 45 + 3);
      line(width/2 - textWidth("Press ENTER to save name")/2 - 3, height/2 + 15/2, width/2 + textWidth("Press ENTER to save name")/2 + 3, height/2 + 15/2);
    }
    
    fill(0);
    
    text(in, width/2 - textWidth(in)/2, height/2 + 15/2);
    if(save){
      text("Press ENTER to save name", width/2 - textWidth("Press ENTER to save name")/2, height/2 + 15/2 + 15);
      text("Leave blank to cancel", width/2 - textWidth("Leave blank to cancel")/2, height/2 + 15/2 + 15*2);
    }else {
      text("Press ENTER to save name", width/2 - textWidth("Press ENTER to save name")/2, height/2 + 15/2 + 15);
      text("Leave blank to cancel", width/2 - textWidth("Leave blank to cancel")/2, height/2 + 15/2 + 15*2);
    }
    
    strokeWeight(1);
    
  }
    
  if(messagelife > 0){
    strokeWeight(3);
    if(loadmacrob){
      
      write = false;
      String message = "Too many loading points";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
      
    }else if(outofbound){
      
      write = false;
      String message = "Macro too big for current position";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(loadmacros){
      
      write = false;
      String message = "No loading points found";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(savemacroupb){
      
      write = false;
      String message = "Too many upper saving points";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(savemacroups){
      
      write = false;
      String message = "No upper saving points found";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(savemacrolowb){
      
      write = false;
      String message = "Too many lower saving points";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(savemacrolows){
      
      write = false;
      String message = "No lower saving points found";
      fill(255);
      stroke(0);
      textSize(25);
      
      rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
      
      fill(255, 0, 0);
      
      text(message, width/2 - (textWidth(message)/2), height/2);
      
      messagelife--;
      
    }else if(nofile){
        String message = "File '" + enter + "' does not exist";
        fill(255);
        stroke(0);
        textSize(25);
        
        rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
        
        fill(255, 0, 0);
        
        text(message, width/2 - (textWidth(message)/2), height/2);
        
        messagelife--;
    }else {
      if(exit || savemacro){
        write = false;
        String message;
        if(!savemacro){
          message = "Saving file as '" + enter + "' and quitting";
        }else {
          message = "Saving macro as '" + enter + "'";
        }
        fill(255);
        stroke(0);
        textSize(25);
        
        rect(width/2 - (textWidth(message)/2) - 10, height/2 - 25, textWidth(message) + 20, 35);
        
        fill(255, 0, 0);
        
        text(message, width/2 - (textWidth(message)/2), height/2);
        
        messagelife--;
      }
    }
    strokeWeight(1);
  }else {
    if(exit && !savemacro){
      exit();
    }
  }
    
}






int mostpower(int i, int j){
  
  int side = 0;
  //1 up
  //2 down
  //3 left
  //4 right
  
  int power = 0;
  
  //check above
  if(j > 0){
    if((grid[i][j-1] > 1 && grid[i][j-1] <= 15) || grid[i][j-1] == 16 || grid[i][j-1] == 25){
      if(grid[i][j-1] > power){
        power = int(grid[i][j-1]);
        side = 1;
      }
    }
  }
  
  //check bellow
  if(j < height/size - 1){
    if((grid[i][j+1] > 1 && grid[i][j+1] <= 15) || grid[i][j+1] == 16 || grid[i][j+1] == 25){
      if(grid[i][j+1] > power){
        power = int(grid[i][j+1]);
        side = 2;
      }
    }
  }
  
  //check left
  if(i > 0){
    if((grid[i-1][j] > 1 && grid[i-1][j] <= 15) || grid[i-1][j] == 16 || grid[i-1][j] == 25){
      if(grid[i-1][j] > power){
        power = int(grid[i-1][j]);
        side = 3;
      }
    }
  }
  
  //check right
  if(i < width/size - 1){
    if((grid[i+1][j] > 1 && grid[i+1][j] <= 15) || grid[i+1][j] == 16 || grid[i+1][j] == 25){
      if(grid[i+1][j] > power){
        power = int(grid[i+1][j]);
        side = 4;
      }
    }
  }
  
  
  return side;
  
}

boolean power(int i, int j){
  
  boolean pow = false;
  
  if(j > 0){
    if((grid[i][j-1] > 1 && grid[i][j-1] <= 15) || grid[i][j-1] == 16 || grid[i][j] == 25){
      pow = true;
    }
  }
  
  //check bellow
  if(j < height/size - 1){
    if((grid[i][j+1] > 1 && grid[i][j+1] <= 15) || grid[i][j+1] == 16 || grid[i][j] == 25){
      pow = true;
    }
  }
  
  //check left
  if(i > 0){
    if((grid[i-1][j] > 1 && grid[i-1][j] <= 15) || grid[i-1][j] == 16 || grid[i][j] == 25){
      pow = true;
    }
  }
  
  //check right
  if(i < width/size - 1){
    if((grid[i+1][j] > 1 && grid[i+1][j] <= 15) || grid[i+1][j] == 16 || grid[i][j] == 25){
      pow = true;
    }
  }
  
  
  return pow;
  
}

void addline(int x, int y){
  
  if(grid[x][y] != selected){
    if((grid[x][y] >= 1 && grid[x][y] <= 15 && selected == 1)){
      if(!dragging){
        grid[x][y] = 0;
        del = true;
      }
    }else {
      grid[x][y] = selected;
      del = false;
    }
  }else if(grid[x][y] == selected){
    if(!dragging){
      del = true;
    }
  }
  
  //1 = line off
  //2 - 15 = line on
  //16 = power
  //17 = lamp off
  //18 = lamp on
  //19 = inverter free
  //20 = inverter up
  //21 = inverter down
  //22 = inverter right
  //23 = inverter left
  //24 = flash off
  //25 = flash on
  //26 = diode off
  //27 = diode up
  //28 = diode down
  //29 = diode right
  //30 = diode left
  //31 = bridge
  //32 = load corner macro
  //33 = save up macro
  //34 = save down macro
  
}


void mousePressed(){
  
  if(mouseX >= width-15 && mouseY <= 15){
    
    quit();
    
  }else if(mouseX >= width-30 && mouseX < width-15 && mouseY <= 15){
    
    load();
    
  }else if(mouseX >= width-45 && mouseX < width-30 && mouseY <= 15){
    
    savemacro();
    
  }else if(mouseX >= width-60 && mouseX < width-45 && mouseY <= 15){
    
    loadmacro();
    
  }else if(mouseX < size && mouseY > size){
    if(mouseY >= size && mouseY < size * 2){
      selected = 1;
    }else if(mouseY >= size * 2 && mouseY < size * 3){
      selected = 16;
    }else if(mouseY >= size * 3 && mouseY < size * 4){
      selected = 17;
    }else if(mouseY >= size * 4 && mouseY < size * 5){
      selected = 19;
    }else if(mouseY >= size * 5 && mouseY < size * 6){
      selected = 24;
    }else if(mouseY >= size * 6 && mouseY < size * 7){
      selected = 26;
    }else if(mouseY >= size * 7 && mouseY < size * 8){
      selected = 31;
    }else if(mouseY >= size * 7 && mouseY < size * 9){
      selected = 32;
    }else if(mouseY >= size * 7 && mouseY < size * 10){
      selected = 33;
    }else if(mouseY >= size * 7 && mouseY < size * 11){
      selected = 34;
    }
  }else if(mouseX >= width - 15 && mouseY > 15 && mouseY <= 35){
    if(mouseY >= 25){
      if(size > 35){
        size--;
        //reset();
      }
    }else {
      if(size < 400){
        size++;
        //reset();
      }
    }
  }else {
  
    if(mouseButton == LEFT){
      if(mouseY > size && mouseX > size){
        xclick = floor(mouseX / size);
        yclick = floor(mouseY / size);
        
        if(grid[int(xclick)][int(yclick)] == selected && selected != 1){
          grid[int(xclick)][int(yclick)] = 0;
          del = true;
        }else {
          if(grid[int(xclick)][int(yclick)] >= 1 && grid[int(xclick)][int(yclick)] <= 15 && selected == 1){
            grid[int(xclick)][int(yclick)] = 0;
            del = true;
          }else if(grid[int(xclick)][int(yclick)] >= 24 && grid[int(xclick)][int(yclick)] <= 25 && selected == 24){
            grid[int(xclick)][int(yclick)] = 0;
            del = true;
          }else {
          addline(int(xclick), int(yclick));
          }
        }
      }
      
    }else {
      
      if(selected == 1){
        selected = 16;
      }else if(selected == 16){
        selected = 17;
      }else if(selected == 17){
        selected = 19;
      }else if(selected == 19){
        selected = 24;
      }else if(selected == 24){
        selected = 26;
      }else if(selected == 26){
        selected = 31;
      }else if(selected == 31){
        selected = 32;
      }else if(selected == 32){
        selected = 33;
      }else if(selected == 33){
        selected = 34;
      }else {
        selected = 1;
      }
    }
    
  }
}


void mouseDragged(){
  
  if(mouseButton == LEFT && mouseY > size && mouseX > size){
    if(xclick != floor(mouseX / size)){
      xclick = floor(mouseX / size);
    }
    if(yclick != floor(mouseY / size)){
      yclick = floor(mouseY / size);
    }
    if(del){
      grid[int(xclick)][int(yclick)] = 0;
    }else if(!del){
      dragging = true;
      addline(int(xclick), int(yclick));
    }
    
  }
  
  
}


void mouseReleased(){
  
  dragging = false;
  
}



void createstrings(){
  
  //1 = line off
  //2 - 15 = line on
  //16 = power
  //17 = lamp off
  //18 = lamp on
  //19 = inverter
  
  for(int i = 0; i < 15; i++){
    
    sel[i] = "   Wire  ";
    
  }
  
  
  sel[15] = "   Power ";
  sel[16] = "   Lamp  ";
  sel[17] = "   Lamp  ";
  sel[18] = " Inverter";
  sel[23] = "  Flash  ";
  sel[25] = "  Diode  ";
  sel[30] = "  Bridge ";
  sel[31] = " Macro IN";
  sel[32] = " Macro OUT UP";
  sel[33] = "Macro OUT DOWN";
  
  
}


String askname(String input){
  
  String name = input;
  
  if(savemacro || loadmacro){
    
    name += 'm';
    
  }
  
  name += ".txt";
  
  entered = true;
  
  return name;
  
}

void quit(){
  
  savemacro = false;
  
  loadmacro = false;
  
  write = true;
  
  load = false;
  
  
}


void load(){
  
  savemacro = false;
  
  loadmacro = false;
  
  write = true;
  
  load = true;
  
  
}



void loadmacro(){
  
  load = false;
  
  savemacro = false;
  
  float cases = 0;
  
  for(int i = 0; i < width/size; i++){ 
    for(int j = 0; j < height/size; j++){
      
      if(grid[i][j] == 32){
        cases++;
      }
      
    }
  }
    
  if(cases == 1){
    
    write = true;
    loadmacro = true;
    loadmacrob = false;
    loadmacros = false;
    savemacroupb = false;
    savemacroups = false;
    savemacrolowb = false;
    savemacrolows = false;
    
  }else if(cases > 1){
    
    messagelife = 200;
    loadmacrob = true;
    loadmacros = false;
    savemacroupb = false;
    savemacroups = false;
    savemacrolowb = false;
    savemacrolows = false;
    
  }else if(cases < 1){
    
    messagelife = 200;
    loadmacrob = false;
    loadmacros = true;
    savemacroupb = false;
    savemacroups = false;
    savemacrolowb = false;
    savemacrolows = false;
    
  }
  
}



void savemacro(){
  
  loadmacro = false;
  load = false;
  
  float caseup = 0;
  float casedown = 0;
  
  for(int i = 0; i < width/size; i++){ 
    for(int j = 0; j < height/size; j++){
      
      if(grid[i][j] == 33){
        caseup++;
      }else if(grid[i][j] == 34){
        casedown++;
      }
      
    }
  }
  
  if(caseup == 1 && casedown == 1){
  
    write = true;
  
    savemacro = true;
    
    loadmacro = false;
    
    load = false;
    
    savemacroupb = false;
    savemacroups = false;
    savemacrolowb = false;
    savemacrolows = false;
    loadmacrob = false;
    loadmacros = false;
    
  }
  
  if(caseup > 1){
    
    messagelife = 200;
    write = false;
    savemacroupb = true;
    savemacroups = false;
    loadmacrob = false;
    loadmacros = false;
    
  }else if(caseup < 1){
    
    messagelife = 200;
    write = false;
    savemacroupb = false;
    savemacroups = true;
    loadmacrob = false;
    loadmacros = false;
    
  }
  
  if(casedown > 1){
    
    messagelife = 200;
    write = false;
    savemacrolowb = true;
    savemacrolows = false;
    savemacroupb = false;
    savemacroups = false;
    loadmacrob = false;
    loadmacros = false;
    
  }else if(casedown < 1){
    
    messagelife = 200;
    write = false;
    savemacrolowb = false;
    savemacrolows = true;
    savemacroupb = false;
    savemacroups = false;
    loadmacrob = false;
    loadmacros = false;
    
  }
    
    
  
}



void keyPressed(){
  
  if(write){
    
    if(key == ENTER){
            
      entered = true;
      enter = in;
      
      //load page
      if(load){
        if(in == "" || textWidth(in) == 0){    
          write = false;
          entered = false;
          in = "";
        }
        if(entered){
          
          lines = loadStrings(askname(enter));
          
          if(fileExists(sketchPath(askname(enter)))){
            
            if(lines.length >= (width/int(lines[0]) - 1) * (height/int(lines[0]) - 1)){
              
              int current = 0;
              
              size = float(lines[current]);
                            
              current++;
              
              for(int i = 0; i <= width/size - 1; i++){
                for(int j = 0; j <= height/size - 1; j++){
                  
                  grid[i][j] = float(lines[current]);
                  
                  current++;
                  
                }
              }
              
            }
            
          nofile = false;
          write = false;
          entered = false;
          in = "";
            
          }else {
            
            nofile = true;
            write = false;
            entered = false;
            in = "";
            messagelife = 200;
            
          }
          
        }
      //load macro
      }else if(loadmacro){
        
        if(in == "" || textWidth(in) == 0){
                    
          write = false;
          entered = false;
          in = "";
        }
        if(entered){
          
          //size = 40;
        
          lines = loadStrings(askname(enter));
          
          if(fileExists(sketchPath(askname(enter)))){
            
            int current = 0;
            
            //add limit
            
            casex = -1;
            casey = -1;
            
            for(int i = 0; i <= width/size - 1; i++){
              for(int j = 0; j <= height/size - 1; j++){
                
                if(grid[i][j] == 32){
                  casex = i;
                  casey = j;
                }
                  
                
              }
            }
            
            if(casex + int(lines[0]) < width/size - 1 && casey + int(lines[1]) < height/size - 1 && casex != -1 && casey != -1){
              
              
              current = 2;
              
              grid[casex][casey] = 0;
              
              for(int i = casex; i <= casex+ int(lines[0]); i++){
                for(int j = casey; j <= casey + int(lines[1]); j++){
                  
                  
                  if(int(lines[current]) != 33 && int(lines[current]) != 34){
                    grid[i][j] = float(lines[current]);
                  }
                  
                  current++;
                  
                }
              }
              
              nofile = false;
              write = false;
              entered = false;
              in = "";
              
              outofbound = false;
              
            }else {
              
              outofbound = true;
              write = false;
              entered = false;
              in = "";
              messagelife = 200;
              
            }
            
          }else {
            
            nofile = true;
            write = false;
            entered = false;
            in = "";
            messagelife = 200;
            
          }
          
        }
        
      }else {
        if(in == "" || textWidth(in) == 0){
          write = false;
          entered = false;
          in = "";
        }
        
        //quit and save
        if(entered && !savemacro){
          
          output = createWriter(askname(enter));
          
          output.println(size);
          
          for(int i = 0; i <= width/size - 1; i++){
            for(int j = 0; j <= height/size - 1; j++){
              
              output.println(grid[i][j]);
              
            }
          }
          
          
          output.flush();
          output.close();
          exit = true;
          messagelife = 200;
          
        //save macro
        }else if(entered && savemacro){
          
          output = createWriter(askname(enter));
          
          
          for(int i = 0; i <= width/size - 1; i++){
            for(int j = 0; j <= height/size - 1; j++){
              
              if(grid[i][j] == 33){
                upx = i;
                upy = j;
              }else if(grid[i][j] == 34){
                lowx = i;
                lowy = j;
              }
              
            }
          }
          
          casew = lowx - upx;
          caseh = lowy - upy;
          
          output.println(casew);
          output.println(caseh);
          
          for(int i = upx; i <= lowx; i++){
            for(int j = upy; j <= lowy; j++){
              
              output.println(grid[i][j]);
              
            }
          }
          
          
          output.flush();
          output.close();
          write = false;
          entered = false;
          exit = false;
          in = "";
          messagelife = 200;
          
        }
      }
      
    }else if(key == BACKSPACE){
      
      if(in.length() >= 1){
        in = in.substring(0, in.length()-1);
      }else {
        in = "";
      }
      
    }else {
      
     in += key;
     
    }
    
  }
  
  if(key == ENTER){
    
    if(messagelife > 0 && !nofile){
      messagelife = 0;
    }
    
  }
  
  if(key == CODED){
    
    if(keyCode == UP){
      
      ymove -= size / 20;
      
    }else if(keyCode == DOWN){
      
      ymove += size / 20;
      
    }else if(keyCode == LEFT){
      
      xmove -= size / 20;
      
    }else if(keyCode == RIGHT){
      
      xmove += size / 20;
      
    }
    
  }
}


boolean fileExists(String path) {
  File file=new File(path);
  boolean exists = file.exists();
  if (exists) {
    return true;
  }
  else {
    return false;
  }
} 



void reset(){
  
  grid = new float[int(width/size) + 1][int(height/size) + 1];
  
  for(int i = 0; i < width/size; i++){
    for(int j = 0; j < height/size; j++){
      
      grid[i][j] = 0;
      
    }
  }
  
}