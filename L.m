function result = L(r, d, phi)
  if abs(phi) < pi/2
    eps = 1;
  elseif abs(phi) > pi/2
    eps = -1;
  else
    printf("Phi equals pi/2!\n");
  end

  squared_diff = r*r - d*d;

  result = (squared_diff*tan(phi))/(eps*(sqrt(r*r + squared_diff*tan(phi)*tan(phi)))+r);
end
