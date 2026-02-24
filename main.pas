  unit main;
  
  uses
    GraphABC, KochFractal;
  
  var
    depth: integer = 0;
    scale: real = 1.0;
    offsetX, offsetY: integer;
    isDragging: boolean = false;
    dragStartX, dragStartY: integer;
  
  procedure RedrawScene;
  begin
    LockDrawing;
    ClearWindow(clWhite);
    
    // Рисуем информационную панель
    SetFontColor(clBlack);
    SetFontSize(12);
    TextOut(10, 10, 'Фрактал: Снежинка Коха');
    TextOut(10, 30, 'Глубина рекурсии: ' + depth.ToString());
    TextOut(10, 50, 'Масштаб: ' + format('{0:f1}', scale));
    
    // Рисуем снежинку Коха
    DrawKochSnowflake(
      WindowWidth div 2 + offsetX, 
      WindowHeight div 2 + offsetY, 
      Round(200 * scale), 
      depth
    );
    
    // Рисуем инструкции
    SetFontSize(10);
    TextOut(20, Windowheight - 80, 'Стрелки <- -> - масштаб');
    TextOut(20, WindowHeight - 60, 'Стрелки ^v - глубина рекурсии (1-6)');
    TextOut(20, WindowHeight - 40, 'ЛКМ + перетаскивание - перемещение');
    TextOut(20, WindowHeight - 20, 'R - сброс, ESC - выход');
    
    UnlockDrawing;
    Redraw;
  end;
  
  procedure KeyDown(Key: integer);
  begin
    case Key of
      // Изменение глубины рекурсии
      VK_Up: 
        if depth < 10 then
        begin
          Inc(depth);
          RedrawScene;
        end;
      
      VK_Down:
        if depth > 0 then
        begin
          Dec(depth);
          RedrawScene;
        end;
      
      // Масштабирование
      VK_Left:
        begin
          scale := scale * 1.1;
          RedrawScene;
        end;
      
      VK_Right:
        begin
          scale := scale * 0.9;
          if scale < 0.1 then scale := 0.1;
          RedrawScene;
        end;
      
      // Сброс
      VK_R:
        begin
          depth := 0;
          scale := 1.0;
          offsetX := 0;
          offsetY := 0;
          RedrawScene;
        end;
      
      // Выход
      VK_Escape:
        Window.Close;
    end;
  end;
  
  procedure MouseDown(x, y, mb: integer);
  begin
    if mb = 1 then // Левая кнопка мыши
    begin
      isDragging := true;
      dragStartX := x - offsetX;
      dragStartY := y - offsetY;
    end;
  end;
  
  procedure MouseMove(x, y, mb: integer);
  begin
    if isDragging then
    begin
      offsetX := x - dragStartX;
      offsetY := y - dragStartY;
      RedrawScene;
    end;
  end;
  
  procedure MouseUp(x, y, mb: integer);
  begin
    if mb = 1 then
      isDragging := false;
  end;
  
  procedure MouseWheel(delta: integer);
  begin
    if delta > 0 then
      scale := scale * 1.1
    else
      scale := scale * 0.9;
    
    if scale < 0.1 then scale := 0.1;
    RedrawScene;
  end;
  
  begin
    // Настройка окна
    SetWindowSize(800, 600);
    CenterWindow;
    
    // Настройка обработчиков событий
    OnKeyDown := KeyDown;
    OnMouseDown := MouseDown;
    OnMouseMove := MouseMove;
    OnMouseUp := MouseUp;
   
    
    // Первоначальная отрисовка
    RedrawScene;
  end.