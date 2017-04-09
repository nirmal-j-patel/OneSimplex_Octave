function result = normalForce(r, eps, phi, phi_ref, normal)
  result = (L(r, abs(2*eps-1)*r, phi_ref) - L(r, abs(2*eps-1)*r, phi))*normal;
end
