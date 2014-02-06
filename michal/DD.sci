function [A,b,ld]=ReadData(bsnm)
//
//
// Calling Sequence
// [A, b, ld] = ReadData(basename) // 
// Parameters
// basename: 
// A: 
// b: 
// ld: 
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

  // napred matici
  [fd, err] = mopen("matice-" + bsnm + ".matice")
  [cnt,n,nz] = mfscanf(fd,"%d%d")
  printf("n=%d nz=%d\n",n,nz)
  A=spzeros(n,n)
  for i=1:nz
      [cnt,ii,jj,val]=mfscanf(fd,"%d %d %lg")
      A(ii,jj)=val
  end
  mclose(fd)
  // potom vektor
  [fd, err] = mopen("bside-" + bsnm + ".strana")
  //[cnt,n,nz] = mfscanf(fd,"%d%d")
  printf("n=%d nz=%d\n",n,nz)
  b=zeros(n,1)
  for i=1:n
      [cnt,val]=mfscanf(fd," %lg")
      b(i) = val
  end
  mclose(fd)
  [fd, err] = mopen("domeny-" + bsnm + ".domeny")
  i=0
  ldd = spzeros(n,n)
  ndom = 0
  citac = 0
  while (meof(fd) == 0)
      citac = citac + 1
      [cnt,ii,jj]=mfscanf(fd,"%d %d")
      if cnt<2 then
          mprintf("koncim s i=%d\n",i)
      else
          i = i + 1 
          if jj>ndom then
              ndom=jj
          end
          if (ii<1) | (jj<1) then
              //printf("%d %d %d\n",citac,ii,jj)
          else
              ldd(jj,ii)=1
          end
      end
  end
  mclose(fd)
  ld = ldd([1:ndom],[1:n])
endfunction

function [domdec]=prepare(A,b,ld,nr)
//
//
// Calling Sequence
// [domdec] = prepare(A, b, ld, nr) // 
// Parameters
// A: 
// b: 
// ld: 
// nr: 
// domdec: 
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

    domdec = 0
endfunction

