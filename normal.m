function result = normal(pointA, pointB)
  AB = pointB - pointA;
  normalized = AB/norm(AB, 2);
  result = zeros(1, 2);
  result(1) = -normalized(2);
  result(2) = normalized(1);
end
