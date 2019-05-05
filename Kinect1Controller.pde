import java.util.List;
import org.openkinect.processing.*;

Kinect kinect = new Kinect(this);

class Kinect1Controller extends PApplet {
  float kinMinThresh = 900;
  float kinMaxThresh = 970;
  PImage img;
  float avgX, avgY;

  void settings() {
    size(kinect.width, kinect.height);

    kinect.initDepth();
    img = createImage(kinect.width, kinect.height, RGB);
    
    this.avgX = 0;
    this.avgY = 0;
  }

  void draw() {
    img.loadPixels();

    // Get the raw depth as array of integers
    int[] depth = kinect.getRawDepth();

    float sumX = 0;
    float sumY = 0;
    float totalPixels = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {      
        int offset = x + y * kinect.width;
        int d = depth[offset];

        if (d > kinMinThresh && d < kinMaxThresh) {
          img.pixels[offset] = color(255, 0, 150);
          sumX += x;
          sumY += y;
          totalPixels++;
        } else {
          img.pixels[offset] = color(51);
        }
      }
    }

    img.updatePixels();
    image(img, 0, 0);

    this.avgX = sumX / totalPixels;
    this.avgY = sumY / totalPixels;

    if (totalPixels >= 900) {
      fill(150, 0, 255);
      ellipse(avgX, avgY, 15, 15);
    }
  }
}
