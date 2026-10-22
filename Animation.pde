// modified from https://processing.org/examples/animatedsprite.html

class Animation {
  PImage[] images;
  int imageCount = 8;
  int frame;
  int w = 50;
  int h = 70;
  
  Animation(String imagePrefix) {
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + (i + 1) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(int xpos, int ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
}
