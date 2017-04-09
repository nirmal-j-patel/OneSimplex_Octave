function result = phi(currPointB, neighborA, neighborC)
  AB = currPointB - neighborA;
  BC = neighborC - currPointB;

  result = acos(dot(AB, BC)/(norm(AB, 2)*norm(BC, 2)));
end
