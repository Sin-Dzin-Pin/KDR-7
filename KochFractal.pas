  unit KochFractal;
  
  interface
  
  procedure DrawKochSnowflake(centerX, centerY, size, depth: integer);
  
  implementation
  
  uses  
  GraphABC;
  
  //Параметризация
  procedure Koch(x1, y1, x2, y2, level: integer);
  var
    x3, y3, x4, y4, x5, y5: integer;
    dx, dy: integer;
  begin
    //База
    if level = 0 then
    begin
      Line(x1, y1, x2, y2);
    end
    else
    begin
  
      dx := (x2 - x1) div 3;
      dy := (y2 - y1) div 3;
      
      x3 := x1 + dx;
      y3 := y1 + dy;
      
      x4 := x2 - dx;
      y4 := y2 - dy;
  
      x5 := x3 + (dx * 50 div 100) - (dy * 866 div 1000);
      y5 := y3 + (dx * 866 div 1000) + (dy * 50 div 100);
      
  //Декомпозиция
      Koch(x1, y1, x3, y3, level - 1);
      Koch(x3, y3, x5, y5, level - 1);
      Koch(x5, y5, x4, y4, level - 1);
      Koch(x4, y4, x2, y2, level - 1);
    end;
  end;
  
  

  procedure DrawKochSnowflake(centerX, centerY, size, depth: integer);
  var
    height: integer;
    topX, topY, leftX, leftY, rightX, rightY: integer;
  begin
   
    height := (size * 866) div 1000;
    
  
    topX := centerX;
    topY := centerY - height div 2;
    
    leftX := centerX - size div 2;
    leftY := centerY + height div 2;
    
    rightX := centerX + size div 2;
    rightY := centerY + height div 2;
    
  
  
    
    SetPenWidth(2);
    
  
    Koch(topX, topY, leftX, leftY, depth);    // Левая сторона
    Koch(leftX, leftY, rightX, rightY, depth); // Основание
    Koch(rightX, rightY, topX, topY, depth);  // Правая сторона
  end;
  
  end.