img = dlmread("image.txt");
points = dlmread("input.txt");

n = size(points)(1);

prevpos = points;
nextpos = zeros(size(points));

for iteration = 1:100
  printf("Starting iteration %d\n", iteration);
  # flush output stream. works in octave. might need to be removed.
  fflush(stdout)
  
  for idx = 1:n
    B = points(idx, :);

# before getting the neighbor points, we need to handle the edge cases where index=1 or n
    if idx == 1
      A = points(n, :);
      C = points(2, :);
    elseif idx == n
      A = points(n-1, :);
      C = points(1, :);
    else
      A = points(idx-1, :);
      C = points(idx+1, :);
    end

    eps_ref = 0.5;
    normal_vec = normal(A, C);
    angle = phi(B, A, C);

    # internal force
    #C1 continuity
    F_int = eps_ref * A + eps_ref*C - B;

    # external force
    radius = 20;
    beta_grad = 0.5;

    # x and y values for the point B as indices so that we can get the value of that point in the backgound image
    x = round(B(1));
    y = round(B(2));

# get the rectangular window using its four points x_low, x_high, y_low, and y_high. these four points are like topleft, top right, bottomleft, and bottomright points on a rectangle
    # we need to use min and max functions to make sure that none of the four corners are outsize the allow range, e.g. negative index
    x_low = max(1, x-radius);
    x_high = min(size(img)(1), x+radius);

    y_low = max(1, y-radius);
    y_high = min(size(img)(2), y+radius);

    window = img(x_low:x_high, y_low:y_high);

    if isempty(window)
      printf("Window empty at position %s", B);
    else
# we want to find out the point with greatest value in the window. if there are multiple points with highest value, select the point that is closest to the center
      w = round(abs(x_high - x_low)/2);
      h = round(abs(y_high - y_low)/2);
      center = [w, h];
      
      
      tmpmax = window(1);
      x2 = 1;
      y2 = 1;

      for window_idx = 1:numel(window);
	val = window(window_idx);
	if val > tmpmax
	  tmpmax = val;
	  [x2, y2] = ind2sub(size(window), idx);
	elseif val == tmpmax
	  [tmp1, tmp2] = ind2sub(size(window), idx);

	  if norm(center-[tmp1, tmp2]) < norm(center-[x2, y2])
	    x2 = tmp1;
	    y2 = tmp2;
	  end
	end
      end

      if tmpmax == 0
	G_i = B;
      else
	G_i = [x2, y2] + [x_low, y_low];
      end

      F_ext = beta_grad*dot((G_i - B), normal_vec)*normal_vec;
      
      # calculate the next position

      if (iteration <= 8)
	alpha = 0.8;
	beta = 0.25;
	gamma = 0.8;
      else
	alpha = 0;
	beta = 1;
	gamma = 0.8;
      end
      #nextPos(i, :) = Pᵗ + (1-γ)*(Pᵗ-Pᵗ⁻¹) + α*F_int + β*F_ext
      nextpos(idx, :) = B + (1-gamma)*(points(idx,:) - prevpos(idx,:)) + alpha*F_int + beta*F_ext;

      printf("nextpos(idx, :) = %f, prevpos(idx, :) = %f, points(idx, :) = %f\n", idx, nextpos(idx, :), prevpos(idx, :), points(idx, :));
    end

    filename = sprintf("mesh/%04d.txt", iteration);
    dlmwrite(filename, points);

    prevpos = points;
    points = nextpos;
    nextpos = zeros(size(points));
  end
end
