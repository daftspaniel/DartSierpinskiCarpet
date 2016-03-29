import 'dart:html';
import 'dart:math';

CanvasRenderingContext2D c2d;
InputElement BlockSizeRange;
InputElement ShiftSizeRange;

void main() {

  CanvasElement ce = querySelector('#surface');
  
  BlockSizeRange = querySelector('#BlockSize')
      ..onChange.listen(Resize);
  
  ShiftSizeRange = querySelector('#ShiftSize')
      ..onChange.listen(Resize);
  
  c2d = ce.getContext("2d");
  drawCarpet();
}

Resize(e){
  drawCarpet();
}

// Render the Carpet on the Canvas.
void drawCarpet() {
  
  c2d.fillStyle = "#080848";
  c2d.fillRect(0,0,1536,1536);
  
  int n = 3;
  int w = BlockSizeRange.valueAsNumber.toInt();
  
  n = pow(n,3);
  
  int red = 0;
  int green = 0;
  int blue = 0;
  int shift = ShiftSizeRange.valueAsNumber.toInt();;
  
  for (int i=0;i< n; i++)
    for (int j=0;j< n; j++){

      if (isCarpet(i, j)){
        red = ((w*j + shift) % 355).clamp(20, 255);
        green =( (w*i + shift) % 355).clamp(20, 255);
        blue = ((w*j+w*i + shift) % 355).clamp(40,255);
        c2d.fillStyle = 'rgb($red, $green, $blue)';        
      }
      else 
        c2d.fillStyle = 'rgb(0,0,10)';

      c2d.fillRect(i*w, j*w, w, w);
    }
}

// Test if point x,y is part of the carpet.
bool isCarpet(int x, int y){

  while (true==true){
    if (x==0 || y==0)
      return true;
    else if (x % 3 == 1 && y % 3 == 1)
      return false;
    x = x ~/ 3;
    y = y ~/ 3;
  }
  return true;
}
