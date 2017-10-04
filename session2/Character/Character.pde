// Set display window size:
size(500, 500);

// Paint background white:
background(255);

// The character is drawn centered in the display window,
// that is, at (250, 250), with a height of 390. The
// center is conventional, since we might have chosen
// a somewhat different center point. The height of 390
// will be considered the normal scale, i.e., scale 1.

// Set white fill so that the following shapes are
// filled with white (until the next call to fill()):
fill(255);

// Set all lines and borders to black until the next
// call to stroke():
stroke(0);

// Draw the head circle:
ellipse(250, 100, 80, 80);

// Set black fill for the eyes:
fill(0);

// Draw the eyes:
ellipse(220, 100, 15, 15);
ellipse(270, 100, 15, 15);

// Set white fill again to draw the torso:
fill(255);

// Draw the torso rectangle:
rect(240, 140, 20, 160);

// Draw the left leg:
line(240, 300, 200, 450);

// Draw the right leg:
line(260, 300, 300, 450);

// Draw the right arm top:
line(260, 160, 300, 200);

// Draw the right arm bottom:
line(300, 200, 250, 240);

// Draw the left arm top:
line(240, 160, 200, 180);

// Draw the left arm bottom:
line(200, 180, 150, 160);

// Draw the fingers:
line(153, 150, 145, 130);
line(153, 150, 158, 130);

// Draw the hand circle:
ellipse(150, 155, 15, 15);