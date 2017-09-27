// Processing program used to generate Exercise 3 (guess the commands) of Session 1.

// Display window will be 400 pixels wide and 400 pixels high:
size(400, 400);

// Background will be mid-level gray:
background(128, 128, 128);
// Could also be:
background(128);

// Set shape fill color to red, that is, a maximum intensity (255) in the red channel,
// and a minimum intensity (0) in the green and blue channels:
fill(255, 0, 0);
// All shapes will be filled with red from this point on, unless the function fill() is
// called again.

// Draw the red rectangle with top-left corner in (x, y) = (50, 50), width 150, and height
// 150:
rect(50, 50, 150, 150);
// Remember that x is the horizontal (left to right) coordinate and y is the vertical
// (top to bottom) coordinate. The origin, that is, the point with (x, y) = (0, 0) is by
// default in the top-left corner of the display window.

// Set shape fill color to green, that is, a minumum intensity (0) in the red channel, a
// maximum intensity (255) in the green channel, and a minimum intensity (0) in the blue
// channels:
fill(0, 255, 0);
// Draw the green rectangle with top-left corner in (x, y) = (200, 50), width 150, and
// height 150:
rect(200, 50, 150, 150);

// Set shape fill color to blue:
fill(0, 0, 255);
rect(50, 200, 150, 150);

// Set shape fill color to white, that is, a maximum intensity (255) in all channels
// (R, G, B):
fill(255, 255, 255);
rect(200, 200, 150, 150);

fill(0, 0, 0, 0);
rect(125, 125, 150, 150);

fill(0, 0, 0, 128);
rect(150, 150, 100, 100);

fill(0, 0, 0, 255);
rect(175, 175, 50, 50);

//background(128, 128, 128);