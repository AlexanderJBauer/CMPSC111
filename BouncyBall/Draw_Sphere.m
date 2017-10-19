function Draw_Sphere(xc,yc,zc,R)
    [x,y,z] = sphere;
    surfl(R*x+xc,R*y+yc,R*z+zc);
    shading interp; colormap(autumn);
end