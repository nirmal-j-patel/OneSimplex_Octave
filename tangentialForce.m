# uses normal or C1 continuity
function result = tangentialForce(pointB, eps_ref, neighborA, neighborC)
  result = eps_ref * neighborA + eps_ref*neighborC - pointB
end
