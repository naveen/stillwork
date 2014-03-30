//The original Cinema Redux script was written by Brendan Dawes. This script has been adapted from his work.
//Brendan's version captured frames from DVD using an analog input, this version captures frames directly from Quicktime video
import processing.video.*;
Movie myMovie;
int xpos = 0;
int ypos = 0;
int VWIDTH = 176; // width of capture
int VHEIGHT = 96; // height of capture
int MOVIEWIDTH = VWIDTH * 30; // width is equivalent to 1 minute of film time
int MOVIEHEIGHT;
int MAXWIDTH = MOVIEWIDTH - VWIDTH;
float MOVIEDURATION;

void setup() {
  myMovie = new Movie(this, "../Take_Two.mov"); //change movie.mov to the filename of your Quicktime movie
  MOVIEDURATION = (myMovie.duration()); // gets the duration of the movie in seconds
  MOVIEHEIGHT = VHEIGHT * int(MOVIEDURATION / 30) + VHEIGHT; // height of the stage is based on the length of your film
  // note that the last frame of the film will repeat until it reaches the end of the current line
  size(MOVIEWIDTH, MOVIEHEIGHT);
  background(0); // sets the background of the stage to black
  frameRate(1); // forces the video to play at one frame per second
  myMovie.play();
}

void draw() {
  if(myMovie.available()) { // checks to see if the next frame is ready for processing
    myMovie.read();
    image(myMovie, xpos, ypos, VWIDTH, VHEIGHT);
    xpos += VWIDTH;
    if (xpos > MAXWIDTH) {
      xpos = 0;
      ypos += VHEIGHT;
    }
    
    if(ypos > MOVIEHEIGHT) {
      saveFrame("my_movie_dna.tif"); // saves a tiff image to the folder of the current sketch when the end of the movie is reached
      delay(2000); // pauses two seconds to save the file
      noLoop(); // exits the draw loop so that the process ends
    }
    
    delay(100); // waits one tenth of a second before repeating the draw function
  }
}
