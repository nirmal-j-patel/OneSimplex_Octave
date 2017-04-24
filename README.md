This repository contains Octave/MATLAB source code for 2d 1-simplex models. You can execute main.m to execute the script. However, you need to make sure that you create two folders: "mesh" and "plot". After each iteration, the script will write the 1-simplex mesh in the mesh folder as a list of points. The script will write images in the plot folder.

You will need two files as the input. Sample input files are in the repository.
1. The initial 1-simplex mesh as a text file containing a list of vertices in order. Essentially, this file is a csv file with the first column as the x coordinates and the second column as the y coordinates of the vertices
2. The background image as a text format. Essentially, this file is a 2D array of pixels. The vertices are attacted towards pixels with high intensities in the image. In order to generated such an image, I used vesselness filter in order to extract lines/curves.

The code does not work correctly yet.

You will want to modify the parameters defined in the script, especially alpha, beta, and gamma. As of now, these variables are defined starting line 100. You can also make the value of the variables change depending on which iteration you are in. For example, check line 91-99. It sets the values of alpha,beta, and gamma differently for the first 8 iterations. This is sometimes useful to make the mesh evolve how you want to. I have found that I need to do a lot of testing to figure out the best values for these variables.
