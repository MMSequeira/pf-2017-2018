// Processing program used to generate Exercise 3 (guess the commands) of Session 1.


// First, prepare for drawing the shapes by specifying the display window size and the
// background color:

// Display window will be 400 pixels wide and 400 pixels high:
size(400, 400);

// Background will be mid-level gray:
background(128, 128, 128);
// Could also be:
// background(128);


// Then, draw the four main squares (red, green, blue, and white). Notice that, by default
// the borders and lines are drawn in black, so it is not necessary to worry about drawing
// the borders of the squares: they will be drawn automatically when the squares are
// drawn using the rect() function. Remember, though, that the color of borders and lines
// may be changed using the stroke() function.

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
// Draw the blue rectangle with top-left corner in (x, y) = (50, 200), width 150, and
// height 150:
rect(50, 200, 150, 150);

// Set shape fill color to white, that is, a maximum intensity (255) in all channels
// (R, G, B):
fill(255, 255, 255);
// Draw the white rectangle with top-left corner in (x, y) = (200, 200), width 150, and
// height 150:
rect(200, 200, 150, 150);


// Finally, draw the three remaining squares, centered on the display window, starting
// with the largest and finishing with the smallest:

// All of these squares will be black (R, G, B) = (0, 0, 0). The first one, however, has
// opacity 0, that is, it is totally transparent:
fill(0, 0, 0, 0);
// Draw the first rectangle with top-left corner in (x, y) = (125, 125), width 150, and
// height 150:
rect(125, 125, 150, 150);

// The second square has opacity 128 (between 0 and 255), that is, it is half transparent:
fill(0, 0, 0, 128);
// Draw the second rectangle with top-left corner in (x, y) = (150, 150), width 100, and
// height 100:
rect(150, 150, 100, 100);

// The third square has opacity 255 (maximum), that is, it is totally opaque:
fill(0, 0, 0, 255);
// Draw the third rectangle with top-left corner in (x, y) = (175, 175), width 50, and
// height 50:
rect(175, 175, 50, 50);