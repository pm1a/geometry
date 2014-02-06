//////////////////////////////
// konstrukce matic
//  -predpoklada se ze jde o ekvidistantni diskretizaci na obdelniku
// konstruuje diskretizaci dvourozmeneho Laplace
// pomala varianta
function [A] = Laplace2D_old(nx,ny)
    A = spzeros(nx*ny,nx*ny)
    for i = 1: nx
        for j = 1:ny 
            ii=(j-1)*nx + i  // to je skutecny index
            A(ii,ii)=4
            if i>1 then
                A(ii,ii-1)= -1
            end 
            if i<nx then
                A(ii,ii+1)= -1
            end
            if j>1 then
                A(ii,ii-nx)= -1
            end
            if j<ny then
                A(ii,ii+nx)= -1
            end
        end
    end
endfunction

// konstruuje diskretizaci dvourozmeneho Laplace - matice hmotnosti
function [A] = Laplace2D_mass(nx,ny)
//
//
// Calling Sequence
// [A] = Laplace2D_mass(nx, ny) // 
// Parameters
// nx: 
// ny: 
// A: 
// 
// Description
// 
// 
// Examples
// 
// 
// See Also
// 
// 
// Authors
// 

    n = nx*ny
    ii = [1:n]'
    indi = zeros(7*n,1)  // prostor pro data
    indj = indi          // trochu preceneno
    vals=ones(7*n,1)/12
    // napred diagonalu
    vals(1:n) = ones(n,1)/2
    indi(1:n) = ii
    indj(1:n) = ii
    cnt = n // pocitam si kolik je opravdu obsazeno
    // ted obe vedlejsi diagonaly
    indi(n+1:2*n-1)=ii(1:n-1)
    indj(n+1:2*n-1)=ii(2:n)
    indi(2*n:3*n-2)=ii(2:n)
    indj(2*n:3*n-2)=ii(1:n-1)
    cnt = cnt + n+n-2
    // ted ty vzdalenejsi
    indi(cnt+1:cnt+n-nx)=ii(1:n-nx)
    indj(cnt+1:cnt+n-nx)=ii(nx+1:n)
    cnt = cnt + n-nx
    indi(cnt+1:cnt+n-nx)=ii(nx+1:n)
    indj(cnt+1:cnt+n-nx)=ii(1:n-nx)
    cnt = cnt + n-nx
    indi(cnt+1:cnt+n-nx-1)=ii(2:n-nx)
    indj(cnt+1:cnt+n-nx-1)=ii(nx+1:n-1)
    cnt = cnt + n-nx-1
    indi(cnt+1:cnt+n-nx-1)=ii(nx+1:n-1)
    indj(cnt+1:cnt+n-nx-1)=ii(2:n-nx)
    cnt = cnt + n-nx-1
    // ted nastavit matici
    A=sparse([indi(1:cnt), indj(1:cnt)], vals(1:cnt), [n,n])
    // ted smazat ty krizove prvky
    for i=1:ny-1
        i1 = i*nx
        A(i1,i1+1)=0
        A(i1+1,i1)=0
        A(i1,i1+nx-1)=0
        A(i1+nx-1,i1)=0
    end
endfunction

// konstruuje diskretizaci dvourozmeneho Laplace
function [A] = Laplace2D(nx,ny)
    n = nx*ny
    ii = [1:n]'
    indi = zeros(5*n,1)  // prostor pro data
    indj = indi          // trochu preceneno
    vals=-ones(5*n,1)
    // napred diagonalu
    vals(1:n) = 4*ones(n,1)
    indi(1:n) = ii
    indj(1:n) = ii
    cnt = n // pocitam si kolik je opravdu obsazeno
    // ted obe vedlejsi diagonaly
    indi(n+1:2*n-1)=ii(1:n-1)
    indj(n+1:2*n-1)=ii(2:n)
    indi(2*n:3*n-2)=ii(2:n)
    indj(2*n:3*n-2)=ii(1:n-1)
    cnt = cnt + n+n-2
    // ted ty vzdalenejsi
    indi(cnt+1:cnt+n-nx)=ii(1:n-nx)
    indj(cnt+1:cnt+n-nx)=ii(nx+1:n)
    cnt = cnt + n-nx
    indi(cnt+1:cnt+n-nx)=ii(nx+1:n)
    indj(cnt+1:cnt+n-nx)=ii(1:n-nx)
    cnt = cnt + n-nx
    // ted nastavit matici
    A=sparse([indi(1:cnt), indj(1:cnt)], vals(1:cnt), [n,n])
    // ted smazat ty krizove prvky
    for i=1:ny-1
        i1 = i*nx
        A(i1,i1+1)=0
        A(i1+1,i1)=0
    end
endfunction

