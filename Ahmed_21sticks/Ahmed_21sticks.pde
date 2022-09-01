/*
   21 Sticks
 by: Ahmed Qazi
 Menu - Easy - Med - Hard - X
 Choosing right 50% - 70% - 90% -100%
 AI think time
 Random turn to start
 AI - if s % 3 == 0 Take 2
 if s % 3 == 1 Random(1 or 2)
 if s % 3 == 2 Take 1
 Player - click Take 1 or 2
 Update Sticks
 Swap turns
 Win 1 Stick left & AI turn -  0 & player turn
 or Lose 1 Stick & player turn - 0 & AI turn
 */
int sticks = 21;
int turn = 0; //0-init 1-player 2-AI
int level=0;//0=menu 1=e 2=m 3=h 4=x 5=win 6=lose
PImage stickImg, backImg, AIturnImg, menu;
int time=10;
int alarm=-1;  
int timer = 500;
String [] mItems = {"Easy", "Medium", "Hard", "Impossible?"};
float angle = 0;
void setup()
{
  size(1000, 600);
  stickImg = loadImage("stick.png");
  backImg = loadImage("back.jpg");
  AIturnImg = loadImage("ai.png");
  menu = loadImage("backimg.jpg");
}
void draw()
{
  imageMode(CORNER);
  if (level == 0)
    showMenu();
  if (level > 0 && level < 5)
  {
    if (turn==0)
      initGame();
    showGame();
    if (turn == 2)
      AITurn();
    checkEnd();
  }
  if (level >=5)
  {
    showEnd();
  }

}
void mousePressed()
{
  if (level==0)
    menu();
  if (level > 0)
    playerTurn();
}
void menu()
{
  for (int i=0; i<4; i++)
  {
    if (mouseX>400 && mouseX <400+200
      && mouseY>150+i*90 && mouseY<150+i*90+50)
    {
      level = i+1;
      turn=0;
    }
  }
}

void AITurn()
{
  if (alarm == -1)
  {
    alarm = time;
    angle=0;
  }
  else 
  {
    alarm --;
    spinIt();
  }
  if (alarm == 0)
  {
    //swap turns
    int take = howToWin(sticks);
    if (random(100) > 30 + 20*level)
    {
      if (take == 1)
        take=2;
      else take=1;
    }
    sticks -= take;
    turn=1;
  }
}
void playerTurn()
{
  for (int i=0; i<2; i++)
  {
    if (mouseX>305+238*i  && mouseX<305+238*i+150
      && mouseY> 445  && mouseY<445+35 )
    {
      sticks -= i+1;
      turn=2;
    }
  }
  //swap turns
}
void showMenu()
{
  image(menu, 0, 0, width, height);
  textSize(30);
  for (int i=0; i<4; i++)
  {
    if (mouseX>400 && mouseX <400+200
      && mouseY>150+i*90 && mouseY<150+i*90+50)
      fill(#E30E0E);
    else fill(500);
    rect(400, 150+i*90, 200, 60, 100);
    fill(255);
    text(mItems[i], 415, 185+i*90);
  }
}
void initGame()
{
  sticks=21;
  time = 60 - level*10;
  turn = (int)random(1, 3);
}
void showGame()
{
  //show background
  image(backImg, 0, 0, width, height);
  textSize(10);
  fill(0);
  text(mouseX+" "+mouseY, 50, 50);
  // game title
  fill(#0BA230);
  textSize(50);
  text("21 stickies", 380, 120);
  textSize(20);
  text("(Level "+level+")", 420, 140);
  // game rules
  //show the sticks
  for (int i=0; i<sticks; i++)
    image(stickImg, 150+(i%7)*100, 137 + (i/7)*100,
      85, 85);
  //show the Take 1 2 buttons
  rect(305, 445, 150, 35);
  rect(305+238, 445, 150, 35);
  fill(255);
  textSize(20);
  text("Take 1", 305+40, 445+25);
  text("Take 2", 305+238+40, 445+25);
  //show turn - AI waiting
}
void showEnd()
{
  showGame();
  textSize(50);
  if (level == 5)
  {
    fill(#1F3DFC);
    text("You WIN!!", 400, 300);
  }
  if (level == 6)
  {
    fill(#F71414);
    text("You LOSE ur cringe", 400, 300);
  }
}
void checkEnd()
{
  //Win 1 Stick left & AI turn -  0 & player turn
  //or Lose 1 Stick & player turn - 0 & AI turn
  //int level=1;//0=menu 1=e 2=m 3=h 4=x 5=win 6=lose
  
  if ((sticks==1 && turn==2) || sticks ==0 && turn==1)
  {
    level = 5;
  }
  if ((sticks == 1 && turn==1)|| sticks == 0 && turn == 2)
  {
    level = 6;
  }
}
int howToWin(int stx)
{
  if (stx % 3 == 0) return 2;
  if (stx % 3 == 2) return 1;
  return (int)random(1, 3);
}
void keyPressed()
{
  if (key == 'x')
     exit();
}
void spinIt()
{
  pushMatrix();
  imageMode(CENTER);
  translate(800, 450);
  rotate(angle);
  image(AIturnImg, 0, 0, 500, 500);
  angle+= PI/4;
  popMatrix();
}
