function magnitude = magnitude1x3( vector )
%magnitude1x3 COMPUTES THE MAGNITUDE OF A VECTOR SZE 1 ROW x 3 COLUMNS
%   Input:
%       vector: THE VECTOR THAT NEEDS ITS MAGNITUDE CALCULATED
%   Output:
%       magnitude: A SCALAR QUANTITY THAT REPRESENTS THE MAGNITUDE OF vector
    magnitude = sqrt((vector(1)^2+vector(2)^2+vector(3)^2));

end

